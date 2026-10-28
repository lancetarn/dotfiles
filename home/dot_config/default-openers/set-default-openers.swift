// Default GUI app: VS Code for text, data and code files, and for the
// spreadsheet and slide formats so the ChatGPT app does not claim them. VS Code
// shows those as raw bytes only after a binary-file warning and does not
// autosave, so a stray keystroke cannot rewrite them (TextEdit autosaves).
// Run with: swift ~/.config/default-openers/set-default-openers.swift
//
// Uses NSWorkspace rather than duti: on this macOS, duti reports success for
// some types (shell, python, javascript, css) without changing anything.
// Extensions no installed app declares (ex, exs, heex, tf, ...) get a dynamic
// type that macOS will not store a default for, so they are reported and skipped.
import AppKit
import UniformTypeIdentifiers

let defaults: [(bundleID: String, extensions: String)] = [
    ("com.microsoft.VSCode", """
        sql csv tsv json jsonl ndjson yaml yml toml ini cfg conf env txt text log md markdown xml
        graphql gql proto sh bash zsh fish py rb js mjs cjs ts tsx jsx ex exs eex heex leex
        go rs lua vim css scss sass less c h cpp hpp java kt swift tf hcl diff patch
        xlsx xls xlsm pptx
        """),
]

for (bundleID, list) in defaults {
    guard let app = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) else {
        print("\(bundleID) is not installed; skipped.")
        continue
    }
    var seen = Set<String>()
    var skipped: [String] = []
    let group = DispatchGroup()
    for ext in list.split(whereSeparator: \.isWhitespace).map(String.init) {
        guard let type = UTType(filenameExtension: ext), !type.isDynamic else {
            skipped.append(ext)
            continue
        }
        guard seen.insert(type.identifier).inserted else { continue }
        group.enter()
        NSWorkspace.shared.setDefaultApplication(at: app, toOpen: type) { error in
            if let error { print("\(ext) (\(type.identifier)): \(error.localizedDescription)") }
            group.leave()
        }
    }
    group.wait()
    print("\(app.deletingPathExtension().lastPathComponent) set as default for \(seen.count) file types.")
    if !skipped.isEmpty { print("  No registered type, skipped: \(skipped.joined(separator: " "))") }
}
