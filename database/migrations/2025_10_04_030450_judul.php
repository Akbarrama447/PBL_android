<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('titles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained('students')->onDelete('cascade');
            $table->foreignId('supervisor_id')->nullable()->constrained('lecturers')->onDelete('set null');
            $table->text('title');
            $table->text('description')->nullable();
            $table->enum('status', ['diajukan', 'diterima', 'ditolak', 'revisi', 'sidang'])->default('diajukan');
            $table->string('proposal_file_path', 255)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('titles');
    }
};
