package com.alssqr.musliemapp

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import android.view.View
import android.widget.RemoteViews

/**
 * ويدجت التقويم: AppWidgetProvider مباشرة + تخطيط XML بسيط جداً (RemoteViews).
 * البيانات من نفس ملف الـ plugin: [PREFS_NAME].
 */
class CalendarWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        val prefs = homeWidgetPrefs(context)
        for (widgetId in appWidgetIds) {
            try {
                val views = RemoteViews(context.packageName, R.layout.widget_calendar)
                bindCalendar(views, prefs)
                bindTapToOpenApp(
                    context,
                    views,
                    CALENDAR_TAP_BASE + widgetId,
                    R.id.widget_calendar_root,
                    "CalendarWidget",
                )
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                Log.e(TAG, "update failed id=$widgetId", e)
            }
        }
    }

    private fun bindCalendar(views: RemoteViews, prefs: SharedPreferences) {
        views.setTextViewText(
            R.id.cal_moon,
            WidgetPrefs.string(prefs, "cal_moon", ""),
        )
        views.setTextViewText(
            R.id.cal_hijri_day,
            WidgetPrefs.string(prefs, "cal_hijri_day", "—"),
        )
        views.setTextViewText(
            R.id.cal_hijri_month,
            WidgetPrefs.string(prefs, "cal_hijri_month", ""),
        )
        views.setTextViewText(
            R.id.cal_hijri_year,
            WidgetPrefs.string(prefs, "cal_hijri_year", ""),
        )
        views.setTextViewText(
            R.id.cal_greg,
            WidgetPrefs.string(prefs, "cal_greg", ""),
        )
        val ramadan = WidgetPrefs.string(prefs, "cal_ramadan", "")
        if (ramadan.isEmpty()) {
            views.setViewVisibility(R.id.cal_ramadan, View.GONE)
        } else {
            views.setViewVisibility(R.id.cal_ramadan, View.VISIBLE)
            views.setTextViewText(R.id.cal_ramadan, ramadan)
        }
    }

    companion object {
        private const val TAG = "CalendarWidget"

        /** أساس لـ requestCode حتى لا يتداخل مع ويدجت المواقيت. */
        private const val CALENDAR_TAP_BASE = 51_000

        /** مطابق لـ HomeWidgetPlugin (home_widget). */
        const val PREFS_NAME: String = "HomeWidgetPreferences"

        fun homeWidgetPrefs(context: Context): SharedPreferences =
            context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    }
}
