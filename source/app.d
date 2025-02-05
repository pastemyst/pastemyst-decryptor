import std.stdio;
import crypto.aes;
import crypto.padding;
import scrypt.password;
import std.base64;
import std.range;

int main(string[] args)
{
	string encryptedData = args[1];
	string encryptedKey = args[2];
	string salt = args[3];
	string password = args[4];

	string passwordHash = genScryptPasswordHash(password, cast(string) Base64.decode(salt), SCRYPT_OUTPUTLEN_DEFAULT,
		   524_288, SCRYPT_R_DEFAULT, SCRYPT_P_DEFAULT);

	string jsonData;

	try
	{
		ubyte[16] iv = 0;
		string key = cast(string) AESUtils.decrypt!AES256(cast(const(ubyte[])) Base64.decode(encryptedKey),
				passwordHash, iv, PaddingMode.PKCS5);

		jsonData = cast(string) AESUtils.decrypt!AES256(cast(const(ubyte[])) Base64.decode(encryptedData),
				key, iv, PaddingMode.PKCS5);

		writeln(jsonData);

		return 0;
	}
	catch (Exception)
	{
        return 1;
	}
}
