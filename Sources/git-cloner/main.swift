let defaultPath = "~/Programming/"

let count = CommandLine.arguments.count
if count < 2 {
    print("Usage: git-cloner URL [Options]")
} else {
    let URL = CommandLine.arguments[1]

    // Filter out Element 0: "http:" and Element 1: ""
    var folderList = URL.components(separatedBy: "/")[2...]
    let gitName = folderList.removeLast()
    
    var targetFolder = defaultPath
    for folder in folderList {
        targetFolder += (folder + "/")
    }
    run(command: "mkdir", arguments: ["-p", targetFolder])
    run(command: "git", arguments: ["clone"] + CommandLine.arguments[1...] + [targetFolder + gitName])
}

