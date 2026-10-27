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
        int height = 1120;
        using (Bitmap bmp = new Bitmap(width, height))
        using (Graphics g = Graphics.FromImage(bmp))
        {
            g.SmoothingMode = SmoothingMode.AntiAlias;
            g.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            g.PixelOffsetMode = PixelOffsetMode.HighQuality;

            g.Clear(Color.White);

            Font fontBoxHeader = new Font("Times New Roman", 17.5f, FontStyle.Bold);
            Font fontSub = new Font("Times New Roman", 13.5f, FontStyle.Bold);
            Font fontBody = new Font("Times New Roman", 14f, FontStyle.Regular);
            Font fontBadgeH = new Font("Times New Roman", 16f, FontStyle.Bold);
            Font fontBadgeSub = new Font("Times New Roman", 13f, FontStyle.Italic);
            Font fontNote = new Font("Times New Roman", 12.5f, FontStyle.Italic);

            Color navyHeader = Color.FromArgb(20, 50, 95);      // Academic Navy
            Color boxBg = Color.FromArgb(250, 252, 255);        // Soft blue tint
            Color greenHeader = Color.FromArgb(20, 90, 50);     // UKRIDA Emerald Green Accent for Y
            Color yBg = Color.FromArgb(246, 253, 248);          // Soft green tint
            Color textDark = Color.FromArgb(30, 41, 59);        // Slate-800
            Color arrowColor = Color.FromArgb(30, 58, 95);      // Arrow Navy

            Pen penNavy = new Pen(navyHeader, 3f);
            Pen penGreen = new Pen(greenHeader, 3f);
            Pen penArrow = new Pen(arrowColor, 3.5f);
            Pen penBadge = new Pen(navyHeader, 1.8f);

            SolidBrush brushWhite = new SolidBrush(Color.White);
            SolidBrush brushText = new SolidBrush(textDark);
            SolidBrush brushNavyText = new SolidBrush(navyHeader);
            SolidBrush brushGreenText = new SolidBrush(greenHeader);
            SolidBrush brushBadgeBg = new SolidBrush(Color.White);
            SolidBrush brushArrow = new SolidBrush(arrowColor);

            Action<float, float, float, float, Color, Color, Pen, string, string, string[], bool> drawBox = 
                (x, y, w, h, hCol, bCol, borderPen, title, code, indicators, isY) =>
            {
                float headerH = 62f;
                using (SolidBrush bBrush = new SolidBrush(bCol))
                using (SolidBrush hBrush = new SolidBrush(hCol))
                {
                    g.FillRectangle(bBrush, x, y + headerH, w, h - headerH);
                    g.FillRectangle(hBrush, x, y, w, headerH);
                }

                g.DrawRectangle(borderPen, x, y, w, h);
                g.DrawLine(borderPen, x, y + headerH, x + w, y + headerH);

                StringFormat sfCenter = new StringFormat
                {
                    Alignment = StringAlignment.Center,
                    LineAlignment = StringAlignment.Center
                };

                string fullTitle = string.IsNullOrEmpty(code) ? title : (title + " (" + code + ")");
                g.DrawString(fullTitle, fontBoxHeader, brushWhite, new RectangleF(x, y, w, headerH), sfCenter);

                float curY = y + headerH + 16f;
                float padX = x + 24f;

                g.DrawString("Indikator Baku Operasional:", fontSub, isY ? brushGreenText : brushNavyText, padX, curY);
                curY += 28f;

                foreach (var ind in indicators)
                {
                    using (SolidBrush dotBrush = new SolidBrush(isY ? greenHeader : navyHeader))
                    {
                        g.FillEllipse(dotBrush, padX + 4f, curY + 6f, 6.5f, 6.5f);
                    }
                    g.DrawString(ind, fontBody, brushText, new RectangleF(padX + 18f, curY, w - 35f, 36f));
                    curY += 34f;
                }
            };

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

                float bx = x1 + (x2 - x1) * 0.44f;
                float by = y1 + (y2 - y1) * 0.44f;
                float bw = 240f;
                float bh = 60f;

                RectangleF bRect = new RectangleF(bx - bw / 2f, by - bh / 2f, bw, bh);
                g.FillRectangle(brushBadgeBg, bRect);
                g.DrawRectangle(penBadge, bRect.X, bRect.Y, bRect.Width, bRect.Height);

                StringFormat sfBadge = new StringFormat
                {
                    Alignment = StringAlignment.Center,
                    LineAlignment = StringAlignment.Center
                };

                g.DrawString(bH, fontBadgeH, brushNavyText, new RectangleF(bRect.X, bRect.Y + 4f, bw, 26f), sfBadge);
                g.DrawString(bSub, fontBadgeSub, brushText, new RectangleF(bRect.X, bRect.Y + 28f, bw, 26f), sfBadge);
            };

            // Layout coordinates
            float boxW = 660f;
            float boxH = 240f;
            float xLeft = 100f;
            float xRight = 1540f;
            float yBoxW = 660f;
            float yBoxH = 360f;

            // X1
            float boxY1 = 80f;
            drawBox(xLeft, boxY1, boxW, boxH, navyHeader, boxBg, penNavy,
                "BRAND IMAGE", "X1", new string[] {
                    "Citra Perusahaan (Corporate Image)",
                    "Citra Pengguna (User Image)",
                    "Citra Armada Listrik (Product Image)"
                }, false);

            // X2
            float boxY2 = 360f;
            drawBox(xLeft, boxY2, boxW, boxH, navyHeader, boxBg, penNavy,
                "BRAND TRUST", "X2", new string[] {
                    "Keandalan Merek (Brand Reliability)",
                    "Itikad Baik & Integritas (Benevolence & Integrity)",
                    "Kompetensi Pengemudi (Driver Competence)"
                }, false);

            // X3
            float boxY3 = 640f;
            drawBox(xLeft, boxY3, boxW, boxH, navyHeader, boxBg, penNavy,
                "PERCEIVED SAFETY", "X3", new string[] {
                    "Keselamatan Berkendara (Driving Safety)",
                    "Keamanan Pribadi Penumpang (Personal Security)",
                    "Keandalan Teknis Armada Listrik (Vehicle EV Safety)"
                }, false);

            // Y (Centered vertically: mid = (80 + 640 + 240) / 2 = 480; yY = 480 - 180 = 300)
            float yY = 300f;
            drawBox(xRight, yY, yBoxW, yBoxH, greenHeader, yBg, penGreen,
                "PURCHASE DECISION", "Y", new string[] {
                    "Kemantapan Menjatuhkan Pilihan pada Green SM",
                    "Kebiasaan & Frekuensi Menggunakan Jasa",
                    "Memberikan Rekomendasi kepada Pihak Lain",
                    "Komitmen Penggunaan Ulang (Repeat Usage)",
                    "Preferensi Utama Transportasi di Jakarta Barat"
                }, true);

            // Arrows
            float outX = xLeft + boxW;
            float inX = xRight;

            // Arrow 1: X1 -> Y
            drawArrow(outX, boxY1 + boxH / 2f, inX, yY + 70f, "H1 (+)", "Positif & Signifikan");

            // Arrow 2: X2 -> Y (Straight horizontal)
            drawArrow(outX, boxY2 + boxH / 2f, inX, yY + yBoxH / 2f, "H2 (+)", "Positif & Signifikan");

            // Arrow 3: X3 -> Y
            drawArrow(outX, boxY3 + boxH / 2f, inX, yY + yBoxH - 70f, "H3 (+)", "Positif & Signifikan");

            // Footnote / Source caption
            StringFormat sfBottom = new StringFormat { Alignment = StringAlignment.Center };
            using (SolidBrush brushNote = new SolidBrush(Color.FromArgb(100, 116, 139)))
            {
                g.DrawString("Sumber: Model Konseptual Penelitian, diadaptasi dari Kotler et al. (2022), Zeithaml et al. (2023), Tjiptono (2022), serta Studi Empiris Terdahulu (2026)",
                    fontNote, brushNote, width / 2f, 960f, sfBottom);
            }

            bmp.Save(outputPath, ImageFormat.Png);
        }
    }
}
"@

Add-Type -TypeDefinition $code -ReferencedAssemblies "System.Drawing.dll"

$outPng = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\images\kerangka_pemikiran.png"
[DiagramGenerator]::Generate($outPng)

Write-Host "Diagram successfully rendered to: $outPng"
