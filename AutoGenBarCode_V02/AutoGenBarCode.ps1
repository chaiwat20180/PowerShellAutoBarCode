Write-Host "========================================================="
Write-Host "=        1. AutoGenBarCode with Code-128                ="
Write-Host "=        2. AutoGenBarCode with MobileQRCode            ="
Write-Host "========================================================="
Write-Host "=                 Create By Chaiwat                     ="
Write-Host "=                                                       ="
Write-Host "=                                                       ="
Write-Host "=   _____ _    _          _______          __  _______  ="
Write-Host "=  / ____| |  | |   /\   |_   _\ \        / /\|__   __| ="
Write-Host "= | |    | |__| |  /  \    | |  \ \  /\  / /  \  | |    ="
Write-Host "= | |    |  __  | / /\ \   | |   \ \/  \/ / /\ \ | |    ="
Write-Host "= | |____| |  | |/ ____ \ _| |_   \  /\  / ____ \| |    ="
Write-Host "=  \_____|_|  |_/_/    \_\_____|   \/  \/_/    \_\_|    ="
Write-Host "=                                                       ="
Write-Host "=                                                       ="
Write-Host "========================================================="
$Select_Number = Read-Host -Prompt 'Please Select Number: '
$Code_Name = ""
switch($Select_Number){
    1{$Code_Name = "Code128"}
    2{$Code_Name = "MobileQRCode"}
    Default {
        Break
    }
}
if($Code_Name += $null){
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
    $barcodeUrl = $baseUrl + $line + "&code="+ $Code_Name +"&translate-esc=on&dpi=360"

    # เซฟไฟล์ภาพ
    $imagePath = Join-Path $saveDirectory ($line + ".png")

    # เช็คว่าถ้าไม่มีโฟลเดอร์จะทำการสร้างโฟลเดอร์ให้
    if (-not (Test-Path $saveDirectory)) {
        New-Item -ItemType Directory -Path $saveDirectory
    }

    # ดาวน์โหลดรูปภาพมาเซฟที่โฟลเดอร์
    Invoke-WebRequest -Uri $barcodeUrl -OutFile $imagePath
    }
}
else{
    Write-Host "Wrong Number"
}