<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('guidance_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('title_id')->constrained('titles')->onDelete('cascade');
            $table->foreignId('sender_id')->constrained('users')->onDelete('cascade');
            $table->enum('log_type', ['chat', 'revisi', 'acc'])->default('chat');
            $table->text('message');
            $table->string('attachment_file_path', 255)->nullable();
            $table->boolean('is_read')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('guidance_logs');
    }
};
