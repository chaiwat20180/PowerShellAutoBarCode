# Set baseUrl จากเว็บ barcode.tec-itใแนท
$baseUrl = "https://barcode.tec-it.com/barcode.ashx?data="

# รับค่ารายการจากไฟล์ list.txt หากไม่มีให้สร้างในโฟลเดอร์นั้น
$textFilePath = "list.txt"

# โฟลเดอร์ที่จะเซฟหากไม่มีจะทำการ Auto Create Folder ให้
$saveDirectory = "AutoGenBarCode"

# อ่านค่าในแต่ละบรรทัดใน list.txt 
$lines = Get-Content $textFilePath

foreach ($line in $lines) {
    # รวมลิงก์
    $barcodeUrl = $baseUrl + $line + "&code=Code128&translate-esc=on"

    # เซฟไฟล์ภาพ
    $imagePath = Join-Path $saveDirectory ($line + ".png")

    # เช็คว่าถ้าไม่มีโฟลเดอร์จะทำการสร้างโฟลเดอร์ให้
    if (-not (Test-Path $saveDirectory)) {
        New-Item -ItemType Directory -Path $saveDirectory
    }

    # ดาวน์โหลดรูปภาพมาเซฟที่โฟลเดอร์
    Invoke-WebRequest -Uri $barcodeUrl -OutFile $imagePath
}

Write-Host "Download completed. Closing in 2 seconds..."
Start-Sleep -Seconds 2
Exit
