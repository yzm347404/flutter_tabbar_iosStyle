/*
 centerSlice 将图片分为 9 个区域：

text
┌─────────────────────────────────┐
│  左上角  │   上边（可拉伸）  │  右上角  │
│ (left,top)│                   │(w-right,top)│
├──────────┼───────────────────┼──────────┤
│  左边     │   中心（可拉伸）  │  右边     │
│(left,top)│                   │(w-right,b) │
├──────────┼───────────────────┼──────────┤
│  左下角   │   下边（可拉伸）  │  右下角   │
│(left,h-bottom)│             │(w-right,h-bottom)│
└───────────────────────────────┴──────────┘
关键约束：

四个角区域不能拉伸，必须保持原始尺寸
因此容器至少要能容纳左右角区域的总宽度
同理，容器至少要能容纳上下角区域的总高度
// 最小宽度
minWidth = left + (originalWidth - right)
// 最小高度  
minHeight = top + (originalHeight - bottom)

当实际容器尺寸小于最小尺寸时，容器尺寸应该等于最小尺寸，就会报错centerSlice was used with a BoxFit that does not guarantee that the image is fully visible
 */