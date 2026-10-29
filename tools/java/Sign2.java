// v2-only 签名器（apksig 2.3.0，单签名者，PKCS12 keystore）。
// 用法（单文件源码模式，无需先编译）：
//   java --add-exports java.base/sun.security.x509=ALL-UNNAMED \
//        --add-exports java.base/sun.security.pkcs=ALL-UNNAMED \
//        --add-exports java.base/sun.security.util=ALL-UNNAMED \
//        -cp apksig-2.3.0.jar tools/java/Sign2.java <ks> <pass> <alias> <in.apk> <out.apk>
// 一般不用手敲：tools/apk_build.py --signed-out 会自动调用。
import com.android.apksig.ApkSigner;
import java.io.File;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;
import java.util.Collections;

public class Sign2 {
    public static void main(String[] a) throws Exception {
        String ks = a[0], pass = a[1], alias = a[2], in = a[3], out = a[4];
        KeyStore k = KeyStore.getInstance("PKCS12");
        FileInputStream f = new FileInputStream(ks);
        k.load(f, pass.toCharArray());
        f.close();
        PrivateKey pk = (PrivateKey) k.getKey(alias, pass.toCharArray());
        X509Certificate cert = (X509Certificate) k.getCertificate(alias);
        ApkSigner.SignerConfig cfg =
                new ApkSigner.SignerConfig.Builder("CERT", pk, Collections.singletonList(cert)).build();
        ApkSigner.Builder b = new ApkSigner.Builder(Collections.singletonList(cfg))
                .setInputApk(new File(in))
                .setOutputApk(new File(out))
                .setV1SigningEnabled(false)
                .setV2SigningEnabled(true);
        b.build().sign();
        System.out.println("signed " + new File(out).length());
    }
}