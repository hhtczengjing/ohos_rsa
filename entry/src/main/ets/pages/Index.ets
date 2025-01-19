import { JSEncrypt } from '@devzeng/rsa'

@Extend(Text)
function headerStyle() {
  .textAlign(TextAlign.Start)
  .width('100%')
  .padding({ left: 16, right: 16 })
  .fontSize(16)
  .fontColor('#7E8388')
}

@Extend(TextArea)
function inputStyle() {
  .width('100%')
  .padding({ left: 16, right: 16 })
  .borderRadius(0)
  .fontSize(16)
  .fontColor('#020F22')
}

@Extend(Text)
function outputStyle() {
  .textAlign(TextAlign.Start)
  .width('100%')
  .padding({ left: 16, right: 16 })
  .fontSize(16)
  .fontColor('#020F22')
}

@Extend(Button)
function btnStyle() {
  .fontSize(16)
  .fontWeight(FontWeight.Regular)
  .backgroundColor('#344F9C')
  .width('35%')
}

@Entry
@Component
struct Index {
  @State plainText: string = '';
  @State publicKey: string = "";
  @State result: string = '';

  build() {
    Column({ space: 10 }) {
      Text('Public Key: ')
        .headerStyle()

      TextArea({ text: this.publicKey })
        .inputStyle()
        .height('25%')
        .onChange((value) => {
          this.publicKey = value;
        })

      Text('Plain Text: ')
        .headerStyle()

      TextArea({ text: this.plainText })
        .inputStyle()
        .height('25%')
        .onChange((value) => {
          this.plainText = value;
        })

      Button('公钥加密')
        .btnStyle()
        .onClick(() => {
          const result = this.rsaBase64(this.publicKey, this.plainText) as string;
          this.result = result ?? '加密失败';
        })

      if (this.result) {
        Column() {
          Text('Output')
            .headerStyle()

          if (this.result) {
            Text(`${this.result}`)
              .outputStyle()
              .margin({ top: 10 })
          }
        }
        .margin({ top: 20 })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
    }
    .margin({ top: 10 })
    .width('100%')
    .padding({ left: 10, right: 10 })
    .height('100%')
    .width('100%')
  }

  rsaBase64(publicKey: string, plainText: string): string | null {
    if (!publicKey || !publicKey) {
      return null;
    }
    let encrypt = new JSEncrypt({});
    encrypt.setPublicKey(publicKey);
    let pwd = encrypt.encrypt(plainText, 'nopadding');
    if (!pwd) {
      return null;
    }
    return pwd;
  }
}