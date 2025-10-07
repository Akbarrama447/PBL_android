<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Models\Title; 

class Title extends Model
{
    use HasFactory;

    // WAJIB: Daftarkan semua field yang akan diisi secara massal
    protected $fillable = [
        'student_id',
        'supervisor_id',
        'title',
        'description',
        'status',
        'proposal_file_path', // Untuk diisi di method uploadProposal
    ];
    
    // ===================================================
    // ELOQUENT RELATIONSHIPS
    // ===================================================

    public function student()
    {
        return $this->belongsTo(Student::class);
    }

    public function supervisor()
    {
        return $this->belongsTo(Lecturer::class, 'supervisor_id');
    }

    // ... relasi lainnya
}