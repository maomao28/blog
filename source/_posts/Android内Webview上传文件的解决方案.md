---
title: Android内Webview上传文件的解决方案
date: 2021-01-11 16:51:39
tags: Android
---


网上大部分的都是兼容android3，android4的 可以参考这个 [https://stackoverflow.com/questions/5907369/file-upload-in-webview](https://stackoverflow.com/questions/5907369/file-upload-in-webview)


在高版本下以上方法是不生效的，可以参考下列代码

```java
mWebView.setWebChromeClient(new WebChromeClient() {
     //For Android API  = 21 (5.0 OS)
     @Override
     public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> filePathCallback, WebChromeClient.FileChooserParams fileChooserParams) {
         uploadMessageAboveL = filePathCallback;
         openImageChooserActivity();
         return true;
     }
    	...
 });
```

```java
private void openImageChooserActivity() {
     Intent intent = new Intent(
             Intent.ACTION_PICK,
             android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
     startActivityForResult(intent, FILE_CHOOSER_RESULT_CODE);
 }
```

```java
@Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
		if(requestCode == FILE_CHOOSER_RESULT_CODE)
        {
            if (null == mUploadMessage && null == uploadMessageAboveL) return;
            Uri result = data == null || resultCode != RESULT_OK ? null : data.getData();
            if (uploadMessageAboveL != null) {
                onActivityResultAboveL(requestCode, resultCode, data);
            } else if (mUploadMessage != null) {
                mUploadMessage.onReceiveValue(result);
                mUploadMessage = null;
            }
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
```
```java
	@TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private void onActivityResultAboveL(int requestCode, int resultCode, Intent intent) {
        if (requestCode != FILE_CHOOSER_RESULT_CODE || uploadMessageAboveL == null)
            return;
        Uri[] results = null;
        if (resultCode == Activity.RESULT_OK) {
            if (intent != null) {
                String dataString = intent.getDataString();
                ClipData clipData = intent.getClipData();
                if (clipData != null) {
                    results = new Uri[clipData.getItemCount()];
                    for (int i = 0; i < clipData.getItemCount(); i++) {
                        ClipData.Item item = clipData.getItemAt(i);
                        results[i] = item.getUri();
                    }
                }
                if (dataString != null)
                    results = new Uri[]{Uri.parse(dataString)};
            }
        }
        uploadMessageAboveL.onReceiveValue(results);
        uploadMessageAboveL = null;
    }
```
