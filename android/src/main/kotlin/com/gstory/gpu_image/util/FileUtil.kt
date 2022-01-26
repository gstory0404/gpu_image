package com.gstory.gpu_image.util

import android.content.Context
import android.database.Cursor
import android.net.Uri
import android.provider.MediaStore
import java.lang.Exception

/**
 * @Author: gstory
 * @CreateDate: 2022/1/26 2:21 下午
 * @Description: 描述
 */

class FileUtil {
    fun getRealPathFromURI(context: Context, contentUri: Uri): String? {
        var cursor: Cursor? = null
        return try {
            val proj = arrayOf<String>(MediaStore.Images.Media.DATA)
            cursor = context.contentResolver.query(contentUri, proj, null, null, null)
            val column_index = cursor?.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)!!
            cursor.moveToFirst()
            cursor.getString(column_index)
        } catch (e: Exception) {
            e.printStackTrace()
            null
        } finally {
            cursor?.close()
        }
    }

}