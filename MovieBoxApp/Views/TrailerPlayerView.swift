import SwiftUI
import WebKit

struct TrailerPlayerView: UIViewRepresentable {

    let videoKey: String

    func makeUIView(context: Context) -> WKWebView {

        let config = WKWebViewConfiguration()

        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = [.video]

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .black
        webView.isOpaque = false

        let embedHTML = """
        <!DOCTYPE html>
        <html>
        <body style="margin:0">
        <iframe
            width="100%"
            height="100%"
            src="https://www.youtube.com/embed/\(videoKey)?playsinline=1&controls=1"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen>
        </iframe>
        </body>
        </html>
        """

        webView.loadHTMLString(embedHTML, baseURL: nil)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}


struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Construct the YouTube embed URL using the video ID
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
