<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('recents', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('from_id')->unsigned();
            $table->bigInteger('to_id')->unsigned();
            $table->double('amount_from');
            $table->double('amount_to');
            $table->timestamps();

            $table->foreign('from_id')->references('id')->on('currencies')->onDelete('cascade');
            $table->foreign('to_id')->references('id')->on('currencies')->onDelete('cascade');;
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('recents');
    }
};
