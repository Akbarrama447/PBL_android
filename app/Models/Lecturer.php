<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lecturer extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'nip',
        'name',
        'specialization',
    ];

    // Tambahkan relasi kembali ke User
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    // Tambahkan relasi ke Titles
    public function supervisionTitles()
    {
        return $this->hasMany(Title::class, 'supervisor_id');
    }
    // ... relasi lain ...
}