from cryptography.hazmat.primitives.asymmetric import padding, rsa
from cryptography.hazmat.primitives import hashes, serialization
import base64

# Step 1: Load the Public Key from a .pem file
def load_public_key(public_key_path):
    with open(public_key_path, "rb") as key_file:
        public_key = serialization.load_pem_public_key(key_file.read())
    return public_key

# Step 2: Encrypt the given text using RSA with SHA-256 padding
def encrypt_text(plaintext, public_key):
    encrypted = public_key.encrypt(
        plaintext.encode('utf-8'),
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )
    return base64.b64encode(encrypted).decode('utf-8')

# Main Execution
if __name__ == "__main__":
    public_key_path = "public_key.pem"  # Path to your RSA public key
    plaintext = "Student@abc789"

    # Load the public key
    public_key = load_public_key(public_key_path)

    # Encrypt the text
    encrypted_text = encrypt_text(plaintext, public_key)

    print("\n🔐 Encrypted Text (Base64 Encoded):")
    print(encrypted_text)
