import SwiftUI
import Firebase
import FirebaseStorage

struct PokemonRegisterView: View {
    @State private var image = UIImage()
    @State private var isShowPhotoLibrary = false
    
    @State private var id = ""
    @State private var name = ""
    
    let storage = Storage.storage()
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                VStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .border(Color.pink, width: 2)
                    Text("Plz select a picture...")
                }
                .sheet(isPresented: $isShowPhotoLibrary, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                })
            }
            TextField("ID(半角数字)", text: $id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            TextField("名前(カタカナ)", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
            Button(action: {
                // Upload profile image
                let fbUtil = FirebaseUtil()
                fbUtil.register(id: id.description, name: name.description, image: image)
            }) {
                Text("登録")
                    .frame(width: 300)
            }
            .padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(20)
        }
    }
}


struct PokemonRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRegisterView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator  // Coordinater to adopt UIImagePickerControllerDelegate Protcol.
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
