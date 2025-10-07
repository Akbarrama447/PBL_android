<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('defense_schedules', function (Blueprint $table) {
            $table->id();
            $table->foreignId('title_id')->unique()->constrained('titles')->onDelete('cascade');
            $table->date('schedule_date');
            $table->time('schedule_time');
            $table->string('location', 100);
            $table->enum('status', ['scheduled', 'completed', 'canceled'])->default('scheduled');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('defense_schedules');
    }
};
