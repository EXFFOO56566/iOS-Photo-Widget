
import SwiftUI

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "onboard1")),
        UIHostingController(rootView: Subview(imageString: "onboard2")),
        UIHostingController(rootView: Subview(imageString: "onboard3")),
        UIHostingController(rootView: Subview(imageString: "onboard4")),
        UIHostingController(rootView: Subview(imageString: "onboard5"))
    ]
    
    var titles = [howtoText1, howtoText2, howtoText3, howtoText4, howtoText5]
    
    @State var currentPageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
            
            Group {
                Text(titles[currentPageIndex])
                    .font(.title)
                    .multilineTextAlignment(.center)

            }
            .frame(height: 100, alignment: .center)
                .padding()
            HStack {
                
                Spacer()
                Button(action: {
                    if self.currentPageIndex+1 == self.subviews.count {
                        self.currentPageIndex = 0
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    if self.currentPageIndex+1 == self.subviews.count {
                        ButtonContent(image: "xmark.circle")
                    } else {
                        ButtonContent(image: "arrow.right")
                    }
                    
                }
            }
                .padding()
        }
    }
}

struct ButtonContent: View {
    var image : String
    
    var body: some View {
        Image(systemName: image)
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
        .padding()
        .background(Color.orange)
        .cornerRadius(30)
    }
}



#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
#endif
