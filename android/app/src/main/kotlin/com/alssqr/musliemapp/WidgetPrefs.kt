package com.alssqr.musliemapp

import android.content.SharedPreferences

/**
 * قراءة آمنة من تفضيلات home_widget: [SharedPreferences.getString] يرمي إن وُجدت القيمة بنوع
 * آخر (مثلاً Double مخزّن كـ Long)، فيتعطّل تحديث الويدجت ويظهر «لا يمكن تحميل التطبيق المصغر».
 */
internal object WidgetPrefs {
    fun string(prefs: SharedPreferences, key: String, default: String): String {
        if (!prefs.contains(key)) return default
        val v = prefs.all[key]
        return if (v is String) v else default
    }
}
