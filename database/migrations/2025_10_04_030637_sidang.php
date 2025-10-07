<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('defense_examiners', function (Blueprint $table) {
            $table->id();
            $table->foreignId('schedule_id')->constrained('defense_schedules')->onDelete('cascade');
            $table->foreignId('lecturer_id')->constrained('lecturers')->onDelete('cascade');
            $table->enum('role', ['ketua', 'penguji_1', 'penguji_2']);
            $table->timestamps();

            $table->unique(['schedule_id', 'lecturer_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('defense_examiners');
    }
};
