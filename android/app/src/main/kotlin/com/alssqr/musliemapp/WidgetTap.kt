package com.alssqr.musliemapp

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import android.widget.RemoteViews

/** فتح التطبيق من الويدجت؛ لا يُلغي التحديث عند الفشل. */
internal fun bindTapToOpenApp(
    context: Context,
    views: RemoteViews,
    pendingIntentRequestCode: Int,
    clickTargetViewId: Int,
    logTag: String,
) {
    try {
        val intent =
            Intent(context, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            }
        var flags = PendingIntent.FLAG_UPDATE_CURRENT
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            flags = flags or PendingIntent.FLAG_IMMUTABLE
        }
        val pi = PendingIntent.getActivity(context, pendingIntentRequestCode, intent, flags)
        views.setOnClickPendingIntent(clickTargetViewId, pi)
    } catch (e: Exception) {
        Log.w(logTag, "tap binding skipped", e)
    }
}
