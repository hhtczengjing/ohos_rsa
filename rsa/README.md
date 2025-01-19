# ohos_rsa

rsa encrypt/decrypt for HarmonyOS

## 安装

```shell
ohpm i @devzeng/rsa
```

OpenHarmony ohpm 环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)

## 使用

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

rsaBase64("plainText", "publicKey");
```