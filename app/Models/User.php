<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens; // <-- WAJIB: Tambahkan ini untuk Sanctum

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable; // <-- WAJIB: Tambahkan HasApiTokens di sini

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role', // <-- WAJIB: Tambahkan 'role' dari migration kamu
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    
    // ===================================================
    // ELOQUENT RELATIONSHIPS
    // ===================================================

    /**
     * Get the student record associated with the user.
     */
    public function student()
    {
        return $this->hasOne(Student::class);
    }

    /**
     * Get the lecturer record associated with the user.
     */
    public function lecturer()
    {
        return $this->hasOne(Lecturer::class);
    }

    /**
     * Get the guidance logs sent by the user (regardless of role).
     */
    public function sentGuidanceLogs()
    {
        return $this->hasMany(GuidanceLog::class, 'sender_id');
    }
}