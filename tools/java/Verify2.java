// v2 验签（apksig 2.3.0）。注意：只接一个参数（APK 路径）——曾误传
// keystore/pass/apk 三参数，导致 keystore 被当成 APK 报
// "Malformed APK: not a ZIP archive"。
//   java --add-exports ... -cp apksig-2.3.0.jar tools/java/Verify2.java <apk>
// tools/apk_build.py 与 tools/apk_verify.py 会自动调用。
import com.android.apksig.ApkVerifier;
import java.io.File;

public class Verify2 {
    public static void main(String[] a) throws Exception {
        ApkVerifier.Result r = new ApkVerifier.Builder(new File(a[0])).build().verify();
        System.out.println("verified=" + r.isVerified()
                + " v1=" + r.isVerifiedUsingV1Scheme()
                + " v2=" + r.isVerifiedUsingV2Scheme());
        System.out.println("signers=" + r.getSignerCertificates().size());
        if (!r.isVerified()) {
            System.out.println("errors=" + r.getErrors());
        }
        if (r.getSignerCertificates().size() > 0) {
            System.out.println("cert=" + r.getSignerCertificates().get(0).getSubjectDN());
        }
    }
}