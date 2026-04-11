package com.alssqr.musliemapp

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.util.Log
import android.widget.RemoteViews

class PrayerTimesWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        val prefs = CalendarWidgetProvider.homeWidgetPrefs(context)
        for (widgetId in appWidgetIds) {
            try {
                val views = RemoteViews(context.packageName, R.layout.widget_prayer_times)
                bindPrayer(views, prefs)
                bindTapToOpenApp(
                    context,
                    views,
                    PRAYER_TAP_BASE + widgetId,
                    R.id.widget_times_root,
                    "PrayerTimesWidget",
                )
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                Log.e(TAG, "update failed id=$widgetId", e)
            }
        }
    }

    private fun bindPrayer(views: RemoteViews, prefs: android.content.SharedPreferences) {
        views.setTextViewText(
            R.id.wt_loc,
            WidgetPrefs.string(prefs, "wn_loc", "—"),
        )
        views.setTextViewText(
            R.id.wt_fajr,
            WidgetPrefs.string(prefs, "wt_fajr", "—"),
        )
        views.setTextViewText(
            R.id.wt_sunrise,
            WidgetPrefs.string(prefs, "wt_sunrise", "—"),
        )
        views.setTextViewText(
            R.id.wt_dhuhr,
            WidgetPrefs.string(prefs, "wt_dhuhr", "—"),
        )
        views.setTextViewText(
            R.id.wt_asr,
            WidgetPrefs.string(prefs, "wt_asr", "—"),
        )
        views.setTextViewText(
            R.id.wt_maghrib,
            WidgetPrefs.string(prefs, "wt_maghrib", "—"),
        )
        views.setTextViewText(
            R.id.wt_isha,
            WidgetPrefs.string(prefs, "wt_isha", "—"),
        )
    }

    companion object {
        private const val TAG = "PrayerTimesWidget"
        private const val PRAYER_TAP_BASE = 52_000
    }
}
