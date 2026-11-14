*** Settings ***
Library         Browser

Suite Setup     Run Keywords    New Browser    chromium    executablePath=C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe    headless=False    AND    New Context
Suite Teardown  Close Browser

Test Setup      New Page    http://127.0.0.1:5500/webtest.html
Test Teardown   Close Page

Test Template   Thuc Thi Dang Nhap

*** Keywords ***
Thuc Thi Dang Nhap
    [Arguments]    ${taikhoan}    ${matkhau}    ${ketqua_kyvong}

    Wait For Elements State    id=username    visible    timeout=5s
    
    Type Text    id=username    ${taikhoan}    delay=50ms
    Type Text    id=password    ${matkhau}     delay=50ms
    Click        id=btnLogin
    Sleep        0.5s

    Wait For Elements State    id=message    visible    timeout=5s
    ${noidung}=    Get Text    id=message
    Should Contain    ${noidung}    ${ketqua_kyvong}

*** Test Cases ***                       ${taikhoan}               ${matkhau}            ${ketqua_kyvong}

TC01 - Dang nhap thanh cong              Admin                     admin123              Đăng nhập thành công! Chào mừng Admin.
TC02 - Nhap sai mat khau lan 1           Admin                     sai_pass              Lỗi: Tài khoản không tồn tại!
TC03 - Nhap sai mat khau lan 2           Admin                     abcdef                Lỗi: Tài khoản không tồn tại!
TC04 - Nhap sai tai khoan                user_sai                  admin123              Lỗi: Tài khoản không tồn tại!
TC05 - Tai khoan viet hoa                ADMIN                     admin123              Lỗi: Tài khoản không tồn tại!
TC06 - De trong mat khau                 Admin                     ${EMPTY}              Lỗi: Vui lòng nhập đầy đủ thông tin!
TC07 - De trong tai khoan                ${EMPTY}                  admin123              Lỗi: Vui lòng nhập đầy đủ thông tin!
TC08 - De trong ca hai                   ${EMPTY}                  ${EMPTY}              Lỗi: Vui lòng nhập đầy đủ thông tin!
TC09 - Tai khoan co ky tu dac biet       Admin@123                 admin123              Lỗi: Tài khoản không tồn tại!
TC10 - Mat khau co dau cach              Admin                     admin 123             Lỗi: Tài khoản không tồn tại!
TC11 - Tai khoan chua so                 Admin123                  admin123              Lỗi: Tài khoản không tồn tại!
TC12 - Tai khoan qua dai                 Admin_Admin_Admin         admin123              Lỗi: Tài khoản không tồn tại!
TC13 - Mat khau chi chua so              Admin                     123456789             Lỗi: Tài khoản không tồn tại!
TC14 - Tai khoan co khoang trang         Ad min                    admin123              Lỗi: Tài khoản không tồn tại!
TC15 - Mat khau viet hoa toan bo         Admin                     ADMIN123              Lỗi: Tài khoản không tồn tại!
TC16 - Dang nhap voi email               admin@gmail.com           admin123              Lỗi: Tài khoản không tồn tại!
TC17 - Tai khoan la chuoi SQLi           ' OR '1'='1               admin123              Lỗi: Tài khoản không tồn tại!
TC18 - Mat khau la chuoi SQLi            Admin                     ' OR '1'='1           Lỗi: Tài khoản không tồn tại!
TC19 - Tai khoan chua ma HTML            <h1>Admin</h1>            admin123              Lỗi: Tài khoản không tồn tại!
TC20 - FAIL: Tai khoan chua script XSS   <script>alert(1)</script> admin123              Đăng nhập thành công! Chào mừng Admin.
TC21 - Nhap sai ca user va pass          test_user                 test_pass             Lỗi: Tài khoản không tồn tại!
TC22 - FAIL: Mat khau la khoang trang    Admin                     ${SPACE}              Đăng nhập thành công! Chào mừng Admin.
TC23 - Tai khoan la khoang trang         ${SPACE}                  admin123              Lỗi: Tài khoản không tồn tại!
TC24 - Nhap nguoc tai khoan va mat khau  admin123                  Admin                 Lỗi: Tài khoản không tồn tại!
TC25 - FAIL: Sai User nhung Dung Pass    NguoiLa                   admin123              Đăng nhập thành công! Chào mừng Admin.
TC26 - Hacker Backdoor                   Hacker                    sai_pass              Lỗi: Tài khoản không tồn tại!
TC27 - FAIL: Ky vong sai thong bao 1     sai_user                  sai_pass              Welcome to panel
TC28 - FAIL: Ky vong sai thong bao 2     Admin                     ${EMPTY}              Vui long nhap mat khau
TC29 - FAIL: Ky vong sai thong bao 3     ${EMPTY}                  admin123              Vui long nhap ten
TC30 - FAIL: Ky vong sai thong bao 4     Admin                     admin123              Loi he thong 500