<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'nim',
        'name',
        'major',
    ];
    
    // Tambahkan relasi kembali ke User
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Tambahkan relasi ke Titles
    public function titles()
    {
        return $this->hasMany(Title::class);
    }
}