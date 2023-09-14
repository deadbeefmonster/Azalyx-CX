
# XXX - List packages to install, the correct Qt packages are in current ports, so perhaps 7.4 release (Qt 6.5.2 with QtHttpServer)
# https://github.com/openbsd/ports/tree/master/x11/qt6/qthttpserver

# Install the latest 3.1.x OpenSSL package

mkdir build
cd build
cmake -DOPENSSL_CRYPTO_LIBRARY=/usr/local/lib/eopenssl31/libcrypto.a -DOPENSSL_INCLUDE_DIR=/usr/local/include/eopenssl31/ ..
make
