class RSA {
    constructor(p, q) {
        this.p = p;
        this.q = q;
    }

    getPublicKeyE(){
        return this.findCoprime()
    }

    getPublicKeyN(){
        return this.getN()
    }

    gcd(x, y) {
        if (typeof x !== "number" || typeof y !== "number") return false;
        x = Math.abs(x);
        y = Math.abs(y);
        while (y) {
            var t = y;
            y = x % y;
            x = t;
        }
        return x;
    }

    modularExponentiation(a, b, n) {
        a = a % n;
        var result = 1;
        var x = a;

        while (b > 0) {
            var leastSignificantBit = b % 2;
            b = Math.floor(b / 2);

            if (leastSignificantBit == 1) {
                result = result * x;
                result = result % n;
            }

            x = x * x;
            x = x % n;
        }
        return result;
    }

    getN() {
        return this.p * this.q;
    }
    getp_q() {
        return (this.p - 1) * (this.q - 1);
    }
    getAscii(a) {
        return a.charCodeAt(0);
    }
    getString(a) {
        return String.fromCharCode(a);
    }

    findCoprime() {
        var p_q = this.getp_q();

        for (var i = 2; i < p_q; i++) {
            if (this.gcd(i, p_q) == 1) {
                return i;
            }
        }
    }

    genPrivateKey() {
        let e = this.findCoprime();
        let p_q = this.getp_q();

        for (var i = 1; i <= p_q; i++) {
            if ((i * e) % p_q == 1) {
                return i;
            }
        }
    }
    EncryptionUser(n, e, text) {
        //console.log("n = ", n, "e = ", e, "Text = ", text);
        let plainText = text;
        let plainCode = [];
        let cipherText = [];
        for (i = 0; i < plainText.length; i++) {
            var value = this.getAscii(plainText[i]);
            plainCode.push(value);
        }

        for (var i = 0; i < plainCode.length; i++) {
            cipherText.push(this.modularExponentiation(plainCode[i], e, n));
        }
        let bruteEncrypt = this.bruteKeyEncrypt(cipherText)
        return bruteEncrypt;
    }

    EncryptionDataBase(text) {
        let plainText = text;
        let plainCode = [];
        let cipherText = [];
        let n = this.getN();
        let e = this.findCoprime();

        for (i = 0; i < plainText.length; i++) {
            var value = this.getAscii(plainText[i]);
            plainCode.push(value);
        }

        for (var i = 0; i < plainCode.length; i++) {
            cipherText.push(this.modularExponentiation(plainCode[i], e, n));
        }
        let bruteEncrypt = this.bruteKeyEncrypt(cipherText)
        return bruteEncrypt;
    }

    bruteKeyEncrypt(cipherText) {
        let plaintext = cipherText;
        var result = [];

        for (let index = 0; index < plaintext.length; index++) {
            let alphabet = (plaintext[index] % 26) + 65;
            result = result + String.fromCharCode(alphabet);
            var k = 0;
            var data = plaintext[index];

            while (data >= 26) {
                k += 1;
                data -= 26;
            }
            result = result + k.toString();
            result = result + ":";
        }

        return result;
    }
    bruteKeyDecrypt(Code) {
        let cipherCode = Code;
        var result = [];
        var alphabet = 0;
        var y = "";

        for (let i in cipherCode) {
            var value = this.getAscii(cipherCode[i]);

            if (value >= 65 && value <= 90) {
                alphabet += value - 65;
            } else if (value >= 48 && value <= 57) {
                y = y + cipherCode[i];
            } else {
                let x = parseInt(y);
                x = x * 26 + alphabet;
                result.push(x);
                alphabet = 0;
                y = "";
            }
        }


        return result;
    }

    Decryption(bruteDeCode) {
        let cipherCode = this.bruteKeyDecrypt(bruteDeCode);
        let d = this.genPrivateKey();
        let n = this.getN();
        let plainCode = [];
        let plainText = "";

        for (var i = 0; i < cipherCode.length; i++) {
            plainCode.push(this.modularExponentiation(cipherCode[i], d, n));
            let value = this.getString(plainCode[i]);
            plainText = plainText + value;
        }

        return plainText;
    }
};

module.exports = RSA;