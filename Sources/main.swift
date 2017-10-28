import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()

var routes = Routes()
routes.add(method: .get, uri: "/", handler: { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!  I'm the brandly new Perfect, swiftly server ;)</body></html>")
    response.completed()
})

server.addRoutes(routes)

server.serverPort = 8182

do {
    try server.start()
} catch PerfectError.networkError(let error, let message){
    print("Network error thrown: \(error); \(message)")
}
