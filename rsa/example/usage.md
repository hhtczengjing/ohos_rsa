```typescript
import { JSEncrypt } from '@devzeng/rsa';

function rsaBase64(plainText: string, publicKey: string): string | null {
  let encrypt = new JSEncrypt({});
  encrypt.setPublicKey(publicKey);
  let pwd = encrypt.encrypt(paramString, 'nopadding');
  if (!pwd) {
    return null;
  }
  return pwd;
}

await rsaBase64("aaaa", "publicKey")
```