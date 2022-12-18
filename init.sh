# allow root login using password
sed -i 's/^.*PermitRootLogin prohibit-password$/PermitRootLogin yes/' \
    /etc/ssh/sshd_config
# allow empty password
sed -i 's/^.*PermitEmptyPasswords no$/PermitEmptyPasswords yes/' \
    /etc/ssh/sshd_config

username=thebesttv

# create regular user
useradd -m -s /bin/bash $username

# set empty password, see
# https://unix.stackexchange.com/a/472966
# https://superuser.com/a/1489024
echo "root:U6aMy0wojraho" | chpasswd -e
echo "$username:U6aMy0wojraho" | chpasswd -e

# do not ask for password when excuting sudo, see
# https://askubuntu.com/a/147265
echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

################################################################
# Generate the same pair of host keys, so that each creation of the
# image remains the same.  To remove the original set of host keys and
# generate new ones:
#   rm -v /etc/ssh/ssh_host*key*
#   ssh-keygen -A
################################################################

cat <<KeyEndsHERE > /etc/ssh/ssh_host_dsa_key
-----BEGIN DSA PRIVATE KEY-----
MIIBugIBAAKBgQCLff/0YmcnzH7hQeVXdZMTzRSBKf599qipWNALIOU9jvvspGft
XHH6WjqiSk1cvTrEBlq1XLwtrY+S5H+7MFhlRImcNtgv+r7mx2v3kxvn56+0M2lw
0K94HIiYuNqnXXCTzB8i5IjK9ah+Xkc9OkBgl9zSp1WQY9MKGFEA/AiFIwIVAIkY
oM0JjLzZ254COlnD3wC4wjOrAoGAWjFsLfKvlA9L5CPH++E68DxUTFcx/GSJGEUD
avtbMgPmJIW5YBJrdSLixo2OtJeuD07G+x2yMI+Emg8xN5eRVWaD8M79kytZHQ7e
u5YRj46DIm99eiT6hfBUgmbS0/iXzpr8gHfMDnlEp0oVZa45M8cfHQMOyL66YOhz
6Lp8Pj0CgYAkn5N32k9p0OO6FGVp13RsLfNYBTcj4HEP4HTjF4VB+Imr0FnayMtx
iztUr7f8p6BMEOwqCIRtmWjtfMuPY5ICTy00LJIBWARQ6zxeDj8h02yx0php93d+
tZXd07Xr6IAUZZjkmHoScwXukZQ0mKl+aJjU89MOCLR77qx0JyD7SQIUZpULwW4F
udkjQXPG1/5x/OG2w3o=
-----END DSA PRIVATE KEY-----
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_dsa_key.pub
ssh-dss AAAAB3NzaC1kc3MAAACBAIt9//RiZyfMfuFB5Vd1kxPNFIEp/n32qKlY0Asg5T2O++ykZ+1ccfpaOqJKTVy9OsQGWrVcvC2tj5Lkf7swWGVEiZw22C/6vubHa/eTG+fnr7QzaXDQr3gciJi42qddcJPMHyLkiMr1qH5eRz06QGCX3NKnVZBj0woYUQD8CIUjAAAAFQCJGKDNCYy82dueAjpZw98AuMIzqwAAAIBaMWwt8q+UD0vkI8f74TrwPFRMVzH8ZIkYRQNq+1syA+YkhblgEmt1IuLGjY60l64PTsb7HbIwj4SaDzE3l5FVZoPwzv2TK1kdDt67lhGPjoMib316JPqF8FSCZtLT+JfOmvyAd8wOeUSnShVlrjkzxx8dAw7Ivrpg6HPounw+PQAAAIAkn5N32k9p0OO6FGVp13RsLfNYBTcj4HEP4HTjF4VB+Imr0FnayMtxiztUr7f8p6BMEOwqCIRtmWjtfMuPY5ICTy00LJIBWARQ6zxeDj8h02yx0php93d+tZXd07Xr6IAUZZjkmHoScwXukZQ0mKl+aJjU89MOCLR77qx0JyD7SQ== root@fe9f71004f1a
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_ecdsa_key
-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIMnioKBQqQtcw8nusVsERCSRJ0CJzlT9XYW9radjRKIloAoGCCqGSM49
AwEHoUQDQgAE6wqJV1z/bg2t/xqf4lPnTlPqT8arz+Mg005jJpGYpY0P9UBJLFQ+
JRVr9JE2MxbldObEwVtpKna34HVgFPg42Q==
-----END EC PRIVATE KEY-----
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_ecdsa_key.pub
ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOsKiVdc/24Nrf8an+JT505T6k/Gq8/jINNOYyaRmKWND/VASSxUPiUVa/SRNjMW5XTmxMFbaSp2t+B1YBT4ONk= root@fe9f71004f1a
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_ed25519_key
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCU1nmUI1qToc7KJipOMks9e3WGCP4/A66ifXAZjtOoEAAAAJiDVR2tg1Ud
rQAAAAtzc2gtZWQyNTUxOQAAACCU1nmUI1qToc7KJipOMks9e3WGCP4/A66ifXAZjtOoEA
AAAEDV7eEsFG6JOCQK66iaYkR3uXTs5UtdhDIgMU963rwv5JTWeZQjWpOhzsomKk4ySz17
dYYI/j8DrqJ9cBmO06gQAAAAEXJvb3RAZmU5ZjcxMDA0ZjFhAQIDBA==
-----END OPENSSH PRIVATE KEY-----
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_ed25519_key.pub
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTWeZQjWpOhzsomKk4ySz17dYYI/j8DrqJ9cBmO06gQ root@fe9f71004f1a
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_rsa_key
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAug+YwfaJxwdXSphAjzeo6bmGsGAAiDrEOm5h/4cwXkJD4/KI
5CxFOXwmfHb4VC9WNpAL22UO9wsVQP+jm0x6pAXNGaJRr+KAEojNJugdK10Om0gg
OOM8VUjk5HpJWANuMRiVHt8BYh0vqWl33xmogjLPE9rVfR/jusmskNXseRCcRWVT
pab+9t9HisGiYvMLuFa54TlRYr9nr3PDSXSrEN1VP+GO7yZCFTe6YlJjyhcm74Id
x3C+UJ/6JyLcU6JS/GOcRoBOXSTAK4JmDrm2He2fZ1UURcQZGyTrTqNA6Z2d8DUK
xKJbaz8C+HW18bLCRPN39HS6PLPh3QEW/iK9nQIDAQABAoIBAQCucNkDYSWjmFpa
8Yv1unV/TBXfXuKg1pgLQFpYvGK4vN/x4v49DtSIJMHgh5ojM45c8YhsVb9GFvoC
SqsVewqwpU+57NkxUeZJekD9bTmL4l9DbsfnDgUO4JzZKV2CSxUQqr+EhghB+KMq
7lsYrHG0P/at4smt2iwkf9huomJmzXPB70bUomDwWgZjndyMA5WvYO1cY6nNFC2Z
fPeM2CdVLi2k4IBWmaKzsdb7bAV1pYJMArwhyxftT+gB6kJI7w7emY7vChds24u5
bhg6Ze09elo+szwk4HrFTRyK+WOecAxq1jw0DVikrWhGBVhNzTzyEd0N7rKfZYNp
AXkRoMFxAoGBAPYk9eJYGbFlO0HMOppb01e24Q8bkWOYWAsKEbX5EdPzk5dHX1x0
7VIzfWbOKfrGmCPGkNCzUv2kOOdI3je6U9+DOQ6nZ96y1A0E0ezdkzIRtyxc/Scz
JCZKE1K/spF+FEZ6yOFm7KnONdXF8NAgbyslAtasxQXt/oWeBJykj+v7AoGBAMGC
xCrO0mRW4dcfr8+0/sxXfj8scexas+mUdO4GcTBJT+4ODFmLmKzlsSY1s5Sv7CwR
TnYKVjVdOaNI2gyP5sZ6R/HlUefP1XBRbdIiV6oDrn4ior4gFoaMtP6I4ezmbgxV
uu1YAO+eHE3/YePrzk2dowFf5wggaS/a597hY/FHAoGBAJM6SFi6maOiCW+x2Nu7
UQ6GNNf0hWItHXx86VsPP7qnVwCFkGSdC9a/NaLobfOyFg5QFw6+NEXClMbCryhm
KwTmWJqLR3XNQUkIOQiVABZSwl2mwUVRMa41YJl+UDD2WOpPRxiLl8N5tHnJi+Dx
hY0o9imx7ac+U59YhSmsxOlBAoGALnUsj3J0BG7vbWxIEz/K5FglERmkiDAGfY+M
uxCE4CjZrbdls6HWF7xVWW0PHiVWOAY3phM5OzqUeeUlpFpv9zqoRyTdEyBMh9ik
2wwvq7uSiunZ1HdzsP3a/jjytKNlzERQymaUYvK8rOUhJU0ZjHzKA6x4lPTjDAAs
JtBJ5EUCgYEAkP9hnMIWNz+MTDlKNfM7uz1bg56XFdbYeW3zwRW3x/AfT1W00xhS
egHZfrGNVjzuoCysco3GLtxWtORAQJT0AXRR0zLW04PakI8AVk9jMqtDymzm0I3y
UYkXIr2GeZ0dTRfwEnAGD1FXD/1gwuynJrI/coQxV8i6kN9+/dgrKAo=
-----END RSA PRIVATE KEY-----
KeyEndsHERE

cat <<KeyEndsHERE > /etc/ssh/ssh_host_rsa_key.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6D5jB9onHB1dKmECPN6jpuYawYACIOsQ6bmH/hzBeQkPj8ojkLEU5fCZ8dvhUL1Y2kAvbZQ73CxVA/6ObTHqkBc0ZolGv4oASiM0m6B0rXQ6bSCA44zxVSOTkeklYA24xGJUe3wFiHS+paXffGaiCMs8T2tV9H+O6yayQ1ex5EJxFZVOlpv7230eKwaJi8wu4VrnhOVFiv2evc8NJdKsQ3VU/4Y7vJkIVN7piUmPKFybvgh3HcL5Qn/onItxTolL8Y5xGgE5dJMArgmYOubYd7Z9nVRRFxBkbJOtOo0DpnZ3wNQrEoltrPwL4dbXxssJE83f0dLo8s+HdARb+Ir2d root@fe9f71004f1a
KeyEndsHERE
