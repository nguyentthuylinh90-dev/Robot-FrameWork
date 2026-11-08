*** Settings ***
Library           SeleniumLibrary

# Mở trình duyệt 1 lần duy nhất
Suite Setup       Open Browser    https://opensource-demo.orangehrmlive.com/    chrome
Suite Teardown    Close Browser

# Refresh lại trang và xóa cookie trước mỗi Test Case
Test Setup        Go To           https://opensource-demo.orangehrmlive.com/
Test Teardown     Delete All Cookies  

# Khai báo sử dụng mẫu Data-driven
Test Template     Kich ban chuan dang nhap

*** Keywords ***
Kich ban chuan dang nhap
    [Arguments]       ${taikhoan}    ${matkhau}    ${ketqua_kyvong}
    
    
    Wait Until Element Is Visible    name=username               timeout=10s
    
    Input Text        name=username               ${taikhoan}
    Input Password    name=password               ${matkhau}
    
    Click Button      css=button[type='submit']
    
    Wait Until Page Contains         ${ketqua_kyvong}            timeout=5s

*** Test Cases ***                                ${taikhoan}              ${matkhau}              ${ketqua_kyvong}

TC01 - Dang nhap thanh cong                       Admin                    admin123                Dashboard
TC02 - Nhap sai mat khau lan 1                    Admin                    sai_pass                Invalid credentials
TC03 - Nhap sai mat khau lan 2                    Admin                    abcdef                  Invalid credentials
TC04 - Nhap sai tai khoan                         user_sai                 admin123                Invalid credentials
TC05 - Tai khoan viet hoa                         ADMIN                    admin123                Invalid credentials
TC06 - De trong mat khau                          Admin                    ${EMPTY}                Required
TC07 - De trong tai khoan                         ${EMPTY}                 admin123                Required
TC08 - De trong ca hai                            ${EMPTY}                 ${EMPTY}                Required
TC09 - Tai khoan co ky tu dac biet                Admin@123                admin123                Invalid credentials
TC10 - Mat khau co dau cach                       Admin                    admin 123               Invalid credentials
TC11 - Tai khoan chua so                          Admin123                 admin123                Invalid credentials
TC12 - Tai khoan qua dai                          Admin_Admin_Admin        admin123                Invalid credentials
TC13 - Mat khau chi chua so                       Admin                    123456789               Invalid credentials
TC14 - Tai khoan co khoang trang                  Ad min                   admin123                Invalid credentials
TC15 - Mat khau viet hoa toan bo                  Admin                    ADMIN123                Invalid credentials
TC16 - Dang nhap voi email                        admin@gmail.com          admin123                Invalid credentials
TC17 - Tai khoan la chuoi SQL Injection           ' OR '1'='1              admin123                Invalid credentials
TC18 - Mat khau la chuoi SQL Injection            Admin                    ' OR '1'='1             Invalid credentials
TC19 - Tai khoan chua ma HTML                     <h1>Admin</h1>           admin123                Invalid credentials
TC20 - Tai khoan chua script XSS                  <script>alert(1)         admin123                Invalid credentials
TC21 - Nhap dung tai khoan nhung sai user         test_user                test_pass               Invalid credentials
TC22 - Mat khau la khoang trang                   Admin                    ${SPACE}                Required
TC23 - Tai khoan la khoang trang                  ${SPACE}                 admin123                Required
TC24 - Nhap nguoc tai khoan va mat khau           admin123                 Admin                   Invalid credentials

TC25 - FAIL: Ky vong sai thong bao 1              Admin                    admin123                Dang nhap that bai
TC26 - FAIL: Ky vong sai thong bao 2              Admin                    sai_pass                Ban da bi khoa
TC27 - FAIL: Ky vong sai thong bao 3              sai_user                 sai_pass                Welcome to panel
TC28 - FAIL: Ky vong sai thong bao 4              Admin                    ${EMPTY}                Vui long nhap mat khau
TC29 - FAIL: Ky vong sai thong bao 5              ${EMPTY}                 admin123                Vui long nhap ten
TC30 - FAIL: Ky vong sai thong bao 6              Admin                    admin123                Loi he thong 500