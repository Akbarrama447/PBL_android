<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Models\Student; // Import Model Student
use App\Models\Lecturer; // Import Model Lecturer
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * Handle user registration.
     */
    public function register(Request $request)
    {
        // 1. VALIDASI
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|in:mahasiswa,dosen,admin', // Validasi role harus ada
            
            // Validasi tambahan berdasarkan role
            'nim' => 'required_if:role,mahasiswa|unique:students,nim',
            'major' => 'required_if:role,mahasiswa',
            'nip' => 'required_if:role,dosen|unique:lecturers,nip',
        ]);

        // 2. BUAT USER BARU
        $user = User::create([
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => $request->role,
            // Field 'name' tidak ada di tabel users, tapi bisa digunakan untuk field 'name' di students/lecturers
        ]);

        // 3. BUAT DATA ROLE SPESIFIK (Student/Lecturer)
        if ($user->role === 'mahasiswa') {
            Student::create([
                'user_id' => $user->id,
                'name' => $request->name,
                'nim' => $request->nim,
                'major' => $request->major,
            ]);
        } elseif ($user->role === 'dosen') {
            Lecturer::create([
                'user_id' => $user->id,
                'name' => $request->name,
                'nip' => $request->nip,
                'specialization' => $request->specialization, // Specialization bisa null
            ]);
        }
        // Admin biasanya di-seed, bukan register

        // 4. BUAT SANCTUM TOKEN
        $token = $user->createToken('authToken', [$user->role])->plainTextToken;

        return response()->json([
            'message' => 'Registration successful',
            'token' => $token,
            'role' => $user->role,
        ], 201);
    }

    /**
     * Handle user login.
     */
    public function login(Request $request)
    {
        // 1. VALIDASI
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // 2. COBA AUTENTIKASI
        if (!Auth::attempt($request->only('email', 'password'))) {
            throw ValidationException::withMessages([
                'email' => ['Invalid credentials.'],
            ])->status(401);
        }

        // 3. AMBIL USER DAN HAPUS TOKEN LAMA
        $user = $request->user();
        
        // Opsional: Hapus token lama untuk memastikan hanya ada satu token aktif per perangkat
        $user->tokens()->delete(); 

        // 4. BUAT SANCTUM TOKEN BARU
        $token = $user->createToken('authToken', [$user->role])->plainTextToken;

        return response()->json([
            'message' => 'Login successful',
            'token' => $token,
            'user_id' => $user->id,
            'role' => $user->role,
        ]);
    }

    /**
     * Handle user logout (revoke token).
     */
    public function logout(Request $request)
    {
        // Hapus token yang sedang digunakan (current token)
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logout successful'
        ]);
    }

    /**
     * Get the authenticated user's profile and specific data.
     */
    public function userProfile(Request $request)
    {
        $user = $request->user();
        $data = ['user' => $user];

        // Load data spesifik berdasarkan role
        if ($user->role === 'mahasiswa') {
            $data['details'] = $user->student;
        } elseif ($user->role === 'dosen') {
            $data['details'] = $user->lecturer;
        }

        return response()->json($data);
    }
}