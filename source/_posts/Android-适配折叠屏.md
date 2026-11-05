---
title: Android 适配折叠屏
date: 2022-01-7 14:04:56
tags: Android
---

折叠屏手机内屏与外屏切换时会默认触发oncreate等一系列事件，并且因为屏幕尺寸的改变导致显示适配问题，需要在 AndroidManifest.xml 对应的activity上添加 android:configChanges="screenLayout"

```
android:configChanges="screenSize|smallestScreenSize|screenLayout"
```

添加后只会触发 onConfigurationChanged 事件，所以可以在 onConfigurationChanged 里适配屏幕的尺寸

``` java
    @Override
    public void onConfigurationChanged(Configuration newConfig){
        setWebView();
        super.onConfigurationChanged(newConfig);
    }

    private void setWebView(){
        // 通过Activity类中的getWindowManager()方法获取窗口管理，再调用getDefaultDisplay()方法获取获取Display对象
        Display display = GameCenter.this.getWindowManager().getDefaultDisplay();
        // 方法一(推荐使用)使用Point来保存屏幕宽、高两个数据
        Point outSize = new Point();
        // 通过Display对象获取屏幕宽、高数据并保存到Point对象中
        display.getSize(outSize);
        // 从Point对象中获取宽、高
        int x = outSize.x;
        int y = outSize.y;
        if(x>1700 && y>1700){
            //根据高度算出实际适配的宽度
            int _x = y * 9 / 16;
            LinearLayout.LayoutParams p= new LinearLayout.LayoutParams(_x,y);
            p.gravity = Gravity.CENTER;
            mWebView.setLayoutParams(p);
        }
        else
        {
            //全屏显示
            LinearLayout.LayoutParams p= new LinearLayout.LayoutParams(x,y);
            p.gravity = Gravity.CENTER;
            mWebView.setLayoutParams(p);
        }
    }
```


