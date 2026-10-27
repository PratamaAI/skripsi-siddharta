$code = @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Text;
using System.Drawing.Imaging;

public class DiagramGenerator
{
    public static void Generate(string outputPath)
    {
        int width = 2300;
        int height = 980;
        using (Bitmap bmp = new Bitmap(width, height))
        using (Graphics g = Graphics.FromImage(bmp))
        {
            g.SmoothingMode = SmoothingMode.AntiAlias;
            g.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            g.PixelOffsetMode = PixelOffsetMode.HighQuality;

            g.Clear(Color.White);

            Font fontOvalHeader = new Font("Times New Roman", 17f, FontStyle.Bold);
            Font fontSubTitle = new Font("Times New Roman", 12f, FontStyle.Italic);
            Font fontBody = new Font("Times New Roman", 13.5f, FontStyle.Regular);
            Font fontBadgeH = new Font("Times New Roman", 15.5f, FontStyle.Bold);
            Font fontBadgeSub = new Font("Times New Roman", 12.5f, FontStyle.Italic);
            Font fontNote = new Font("Times New Roman", 12f, FontStyle.Italic);

            Color navyDark = Color.FromArgb(16, 44, 87);        // UKRIDA Deep Navy
            Color navyBorder = Color.FromArgb(24, 64, 122);     // Border Navy
            Color ovalBg = Color.FromArgb(248, 251, 255);       // Soft ice tint
            Color greenDark = Color.FromArgb(20, 85, 45);       // Emerald Green
            Color greenBorder = Color.FromArgb(24, 105, 55);    // Emerald Border
            Color greenBg = Color.FromArgb(245, 252, 247);      // Soft sage tint
            Color textDark = Color.FromArgb(30, 41, 59);        // Slate text
            Color arrowColor = Color.FromArgb(28, 55, 92);      // Arrow Navy
            Color dividerColor = Color.FromArgb(203, 213, 225); // Slate-300 divider

            Pen penNavy = new Pen(navyBorder, 3.2f);
            Pen penGreen = new Pen(greenBorder, 3.6f);
            Pen penArrow = new Pen(arrowColor, 3.5f);
            Pen penBadge = new Pen(navyBorder, 1.8f);
            Pen penDivider = new Pen(dividerColor, 1.2f);
            penDivider.DashStyle = DashStyle.Dash;

            SolidBrush brushWhite = new SolidBrush(Color.White);
            SolidBrush brushText = new SolidBrush(textDark);
            SolidBrush brushNavyText = new SolidBrush(navyDark);
            SolidBrush brushGreenText = new SolidBrush(greenDark);
            SolidBrush brushBadgeBg = new SolidBrush(Color.White);
            SolidBrush brushArrow = new SolidBrush(arrowColor);

            StringFormat sfCenter = new StringFormat
            {
                Alignment = StringAlignment.Center,
                LineAlignment = StringAlignment.Center
            };

            StringFormat sfBadgeCenter = new StringFormat
            {
                Alignment = StringAlignment.Center,
                LineAlignment = StringAlignment.Center
            };

            // Action to draw an oval construct
            Action<float, float, float, float, Color, Pen, Brush, string, string, string, string[], bool> drawOval = 
                (x, y, w, h, bgCol, borderPen, hBrush, title, varCode, sub, indicators, isY) =>
            {
                // Fill Ellipse
                using (SolidBrush bgBrush = new SolidBrush(bgCol))
                {
                    g.FillEllipse(bgBrush, x, y, w, h);
                }

                // Draw Ellipse Border
                g.DrawEllipse(borderPen, x, y, w, h);

                float centerX = x + w / 2f;
                float startY = isY ? (y + 40f) : (y + 36f);

                // Title
                string fullTitle = string.IsNullOrEmpty(varCode) ? title : (title + " (" + varCode + ")");
                g.DrawString(fullTitle, fontOvalHeader, hBrush, new RectangleF(x + 30f, startY, w - 60f, 28f), sfCenter);

                if (!string.IsNullOrEmpty(sub))
                {
                    startY += 24f;
                    g.DrawString(sub, fontSubTitle, hBrush, new RectangleF(x + 40f, startY, w - 80f, 22f), sfCenter);
                }

                startY += isY ? 24f : 26f;

                // Subtle Divider Line inside ellipse
                float divW = isY ? 360f : 300f;
                g.DrawLine(penDivider, centerX - divW / 2f, startY, centerX + divW / 2f, startY);
                startY += 12f;

                // Indicators (centered, with clean dash prefix)
                float lineH = isY ? 27f : 29f;
                foreach (var ind in indicators)
                {
                    g.DrawString("- " + ind, fontBody, brushText, new RectangleF(x + 45f, startY, w - 90f, lineH + 4f), sfCenter);
                    startY += lineH;
                }
            };

            // Action to draw connecting arrow with hypothesis pill badge
            Action<float, float, float, float, string, string> drawArrow = 
                (x1, y1, x2, y2, bH, bSub) =>
            {
                g.DrawLine(penArrow, x1, y1, x2, y2);

                double theta = Math.Atan2(y2 - y1, x2 - x1);
                float headLen = 22f;
                double headAngle = Math.PI / 6.0;

                PointF[] arrowPts = new PointF[]
                {
                    new PointF(x2, y2),
                    new PointF((float)(x2 - headLen * Math.Cos(theta - headAngle)), (float)(y2 - headLen * Math.Sin(theta - headAngle))),
                    new PointF((float)(x2 - headLen * Math.Cos(theta + headAngle)), (float)(y2 - headLen * Math.Sin(theta + headAngle)))
                };
                g.FillPolygon(brushArrow, arrowPts);

                float bx = x1 + (x2 - x1) * 0.45f;
                float by = y1 + (y2 - y1) * 0.45f;
                float bw = 240f;
                float bh = 58f;

                RectangleF bRect = new RectangleF(bx - bw / 2f, by - bh / 2f, bw, bh);
                g.FillRectangle(brushBadgeBg, bRect);
                g.DrawRectangle(penBadge, bRect.X, bRect.Y, bRect.Width, bRect.Height);

                g.DrawString(bH, fontBadgeH, brushNavyText, new RectangleF(bRect.X, bRect.Y + 4f, bw, 25f), sfBadgeCenter);
                g.DrawString(bSub, fontBadgeSub, brushText, new RectangleF(bRect.X, bRect.Y + 28f, bw, 24f), sfBadgeCenter);
            };

            // Layout coordinates
            float ovalW = 670f;
            float ovalH = 240f;
            float xLeft = 110f;
            float xRight = 1520f;
            float yOvalW = 680f;
            float yOvalH = 390f;

            // X1: Brand Image (Oval)
            float ovalY1 = 40f;
            drawOval(xLeft, ovalY1, ovalW, ovalH, ovalBg, penNavy, brushNavyText,
                "BRAND IMAGE", "X1", null, new string[] {
                    "Citra Perusahaan (Corporate Image)",
                    "Citra Pengguna (User Image)",
                    "Citra Armada Listrik (Product Image)"
                }, false);

            // X2: Brand Trust (Oval)
            float ovalY2 = 320f;
            drawOval(xLeft, ovalY2, ovalW, ovalH, ovalBg, penNavy, brushNavyText,
                "BRAND TRUST", "X2", null, new string[] {
                    "Keandalan Merek (Brand Reliability)",
                    "Itikad Baik & Integritas (Benevolence & Integrity)",
                    "Kompetensi Pengemudi (Driver Competence)"
                }, false);

            // X3: Perceived Safety (Oval)
            float ovalY3 = 600f;
            drawOval(xLeft, ovalY3, ovalW, ovalH, ovalBg, penNavy, brushNavyText,
                "PERCEIVED SAFETY", "X3", null, new string[] {
                    "Keselamatan Berkendara (Driving Safety)",
                    "Keamanan Pribadi Penumpang (Personal Security)",
                    "Keandalan Teknis Armada Listrik (Vehicle Safety)"
                }, false);

            // Y: Purchase Decision (Oval)
            // Centered vertically relative to X constructs: center Y = (40 + 600 + 240)/2 = 440f
            float yY = 440f - yOvalH / 2f; // 440 - 195 = 245f
            drawOval(xRight, yY, yOvalW, yOvalH, greenBg, penGreen, brushGreenText,
                "PURCHASE DECISION", "Y", "Keputusan Pembelian / Penggunaan Jasa", new string[] {
                    "Kemantapan Menjatuhkan Pilihan pada Green SM",
                    "Kebiasaan & Frekuensi Menggunakan Jasa",
                    "Memberikan Rekomendasi kepada Pihak Lain",
                    "Komitmen Penggunaan Ulang (Repeat Usage)",
                    "Preferensi Moda Transportasi di Jakarta Barat"
                }, true);

            // Arrows from X Ovals directly to Y Oval perimeter
            // Arrow 1: X1 -> Y
            drawArrow(775f, 180f, 1530f, 345f, "H1 (+)", "Positif & Signifikan");

            // Arrow 2: X2 -> Y (Horizontal)
            drawArrow(780f, 440f, 1520f, 440f, "H2 (+)", "Positif & Signifikan");

            // Arrow 3: X3 -> Y
            drawArrow(775f, 700f, 1530f, 535f, "H3 (+)", "Positif & Signifikan");

            // Footnote / Source caption at bottom
            StringFormat sfBottom = new StringFormat { Alignment = StringAlignment.Center };
            using (SolidBrush brushNote = new SolidBrush(Color.FromArgb(100, 116, 139)))
            {
                g.DrawString("Sumber: Model Konseptual Penelitian, diadaptasi dari Kotler et al. (2022), Zeithaml et al. (2023), Tjiptono (2022), serta Studi Empiris Terdahulu (2026)",
                    fontNote, brushNote, width / 2f, 895f, sfBottom);
            }

            bmp.Save(outputPath, ImageFormat.Png);
        }
    }
}
"@

Add-Type -TypeDefinition $code -ReferencedAssemblies "System.Drawing.dll"

$outPng = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\images\kerangka_pemikiran.png"
[DiagramGenerator]::Generate($outPng)

Write-Host "Diagram with oval shapes successfully rendered to: $outPng"
