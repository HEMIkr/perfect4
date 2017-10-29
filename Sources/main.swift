import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()


func returnJSONMessage(message: String, response: HTTPResponse) {
    do {
        try response.setBody(json: ["message": message])
            .setHeader(.contentType, value: "application/json")
            .completed()
    } catch {
        response.setBody(string: "Error handling request: \(error)")
            .completed()
    }
}

var routes = Routes()
routes.add(method: .get, uri: "/", handler: { request, response in
    response.setHeader(.contentType, value: "text/html")
    response.setBody(string: "<html><title>Hello, world!</title><body>Hello, world!  I'm the brandly new Perfect, swiftly server ;)</body></html>")
    response.completed()
})
routes.add(method: .get, uri: "/json", handler: { request, response in
    returnJSONMessage(message: "Hello, I'm JSON!", response: response)
})
routes.add(method: .get, uri: "/items/{num_of_items}", handler: { request, response in
    guard
        let numberOfItemsString = request.urlVariables["num_of_items"],
        let numberOfItems = Int(numberOfItemsString)
    else {
        response.completed(status: .badRequest)
        return
    }
    returnJSONMessage(message: "declared number of items: \(numberOfItems)", response: response)
})
routes.add(method: .post, uri: "post", handler: { request, response in
    guard let name = request.param(name: "name") else {
        response.completed(status: .badRequest)
        return
    }
    returnJSONMessage(message: "Hello \(name)", response: response)
})

server.addRoutes(routes)

server.serverPort = 8182

do {
    try server.start()
} catch PerfectError.networkError(let error, let message){
    print("Network error thrown: \(error); \(message)")
}
