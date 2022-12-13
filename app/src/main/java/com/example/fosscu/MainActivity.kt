package com.example.fosscu

import android.content.Intent
import android.media.Image
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.ImageView

class MainActivity : AppCompatActivity() {
    lateinit var event:ImageView
    lateinit var team:ImageView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        event = findViewById(R.id.event)
        team = findViewById(R.id.team)

        event.setOnClickListener {
            val intent = Intent(this, events::class.java)
            startActivity(intent)
        }

        team.setOnClickListener {
            val intent = Intent(this, teams::class.java)
            startActivity(intent)
        }



    }

    fun yes(view: View) {}
}