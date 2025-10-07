<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Title; // WAJIB: Import Model Title
use Illuminate\Support\Facades\Storage; // WAJIB: Import Storage Facade
// use App\Models\Student; // Sudah diakses via $request->user()->student

class TitleController extends Controller
{
    // ... method store() dan method lainnya di sini ...

    /**
     * Handle the upload of the proposal file for a specific title.
     * Route: POST /api/titles/{title}/upload-proposal
     */
    public function uploadProposal(Request $request, Title $title)
    {
        $user = $request->user();
        
        // --- LOGIC DEBUGGING DAN OTORISASI YANG KAMU BERIKAN DIMULAI DI SINI ---
        
        // 1. Cek Otorisasi: Hanya Mahasiswa pemilik judul
        // Pastikan relasi student() sudah didefinisikan di User.php dan user adalah Mahasiswa.
        if ($user->role !== 'mahasiswa' || !$user->student || $user->student->id !== $title->student_id) {
            return response()->json(['message' => 'Akses ditolak. Anda bukan pemilik judul ini atau bukan Mahasiswa.'], 403);
        }

        // 2. Validasi File
        $request->validate([
            'proposal_file' => 'required|file|mimes:pdf,docx,doc|max:5120', // Maks 5MB
        ]);

        // 3. Simpan File (Logic Lanjutan)
        if ($request->hasFile('proposal_file')) {
            $file = $request->file('proposal_file');
            
            // Buat path penyimpanan: proposals/NIM-TitleID.pdf
            $path = $file->storeAs(
                'proposals', 
                $title->student->nim . '-' . $title->id . '.' . $file->extension(),
                'public' // Simpan di storage/app/public/proposals
            );

            // 4. Update Database
            $title->update(['proposal_file_path' => $path]);

            return response()->json([
                'message' => 'Proposal berhasil diupload.',
                'path' => Storage::url($path), 
            ]);
        }

        return response()->json(['message' => 'Gagal mengupload file.'], 500);
    }
}