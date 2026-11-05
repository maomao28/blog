---
title: Android内嵌Webkit适配黑暗模式
date: 2022-01-06 18:31:31
tags: Android
---

白天模式：
{% asset_img IMG_1246.jpg 200%}

黑暗模式：
{% asset_img IMG_1245.jpg 200%}

代码会自动根据手机设置进行适配

``` java
if (WebViewFeature.isFeatureSupported(WebViewFeature.FORCE_DARK)) {
            int nightModeFlags = getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK;

            if (nightModeFlags == Configuration.UI_MODE_NIGHT_YES) {
                //Theme is switched to Night/Dark mode, turn on webview darkening
                WebSettingsCompat.setForceDark(mWebView.getSettings(), WebSettingsCompat.FORCE_DARK_ON);
            }
            else{
                //Theme is not switched to Night/Dark mode, turn off webview darkening
                WebSettingsCompat.setForceDark(mWebView.getSettings(), WebSettingsCompat.FORCE_DARK_OFF);
            }
        }
```