//
//  MenuView.swift
//  IPstatus
//
//  Created by Kemal Icecek on 31.07.2021.
//

import SwiftUI
//import Foundation
import ServiceManagement
//import FoundationNetworking

struct MenuView: View {
    
    @Environment(\.openURL) var openURL
    @Namespace var animation
    @State var currentTab = "addresses"
    @State var localIP: String {
        didSet {
            print("TEEEEESSSSSTTTT")
            publicIP = "deneme"
                
        }
    }
    @State var publicIP: String
    @State private var showPopover = false
    @State private var showPublicPopover = false
    
    let pasteboard = NSPasteboard.general
    @State private var launchAtLogin = false {
        didSet {
            SMLoginItemSetEnabled(Constants.helperBundleID as CFString,
                                  launchAtLogin)
        }
    }
    private struct Constants {
        static let helperBundleID = "com.kemalicecek.LauncherApplication"
    }
    var body: some View {
        VStack{
            Spacer()
                .padding(.horizontal)

            HStack{
                if currentTab == "addresses" {
                    VStack{
                        Text("Local IP:")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.bottom, 4)
                        Text("Public IP:")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                    }
                    .frame(width: 60)
                    VStack{
                        
                        Text(localIP)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.bottom, 4)
                            
                            .onTapGesture() {
                                let queue = DispatchQueue(label: "work-queue")
                                
                                queue.async {
                                    copyOnClick()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    print("dismiss")
                                    showPopover = false
                                }
                            }
                            .popover(isPresented: $showPopover) {
                                Text(" Coppied! ")
                            }
                        Text(publicIP)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
//                            .onChange(of: NetworkMonitor.shared.connectionType, perform: { value in
//                                publicIP = getIPAdresses.getPublicIP()
//                            })
                            .onTapGesture() {
                                
                                let queue = DispatchQueue(label: "work-queue")
                                
                                queue.async {
                                        showPublicPopover = true
                                        pasteboard.clearContents()
                                        pasteboard.setString(publicIP, forType: .string)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    print("dismiss")
                                    showPublicPopover = false
                                }
                            }
                            .popover(isPresented: $showPublicPopover) {
                                Text(" Coppied! ")
                            }
                    }
                    .frame(width: 80)
                    VStack{
                        
                        Button(action: {
                            self.localIP = getIPAdresses.getLocalIP()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                        .padding(.bottom, 4)
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 40)
                        Button(action: {
                            self.publicIP = getIPAdresses.getPublicIP()
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                } else if currentTab == "help" {
                    
                    VStack{
                        
                        Toggle(isOn: $launchAtLogin) {
                            Text(" Launch at Login")
                                .font(.callout)
                                .foregroundColor(.primary)
                        }
                        Button(action: {
                            NSApplication.shared.terminate(self)
                        }, label: {
                            Text("QUIT")
                            //                            Image(systemName: "arrow.clockwise")
                        })
                        .buttonStyle(DefaultButtonStyle())
                    }
                }
                
            }
            Spacer(minLength: 15)
            
            Divider()
                .padding(.top, 2)
                
                // Bottom View...
                .padding(.horizontal)
                .padding(.bottom)
            
            HStack{
                
                Image("github")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                    .onTapGesture(){
                        openURL(URL(string: "https://github.com/kemalicecek")!)
                    }
                
                Text("github.com/kemalicecek")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .onTapGesture(){
                        openURL(URL(string: "https://github.com/kemalicecek")!)
                    }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    if currentTab == "addresses" {
                        currentTab = "help"
                    } else {
                        currentTab = "addresses"
                    }
                }, label: {
                    if currentTab == "addresses" {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.primary)
                    } else {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .foregroundColor(.primary)
                    }
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            
        }
        .frame(width: 250, height: 150)
    }
    private func copyOnClick(){
        showPopover = true
        pasteboard.clearContents()
        pasteboard.setString(localIP, forType: .string)
    }
}

struct CopyView: View {
    @State private var showPopover: Bool = false
    var body: some View {
        VStack {
            Button("Show popover") {
                self.showPopover = true
            }.popover(
                isPresented: self.$showPopover,
                arrowEdge: .bottom
            ) { Text("Popover") }
        } .background(blur(radius: 1.0))
    }
}
struct PublicCopyView: View {
    @State private var showPublicPopover: Bool = false
    var body: some View {
        VStack {
            Button("Show popover") {
                self.showPublicPopover = true
            }.popover(
                isPresented: self.$showPublicPopover,
                arrowEdge: .bottom
            ) { Text("Popover") }
        } .background(blur(radius: 1.0))
    }
}
struct PopoverView: View {
    @State private var showPopoever = false
    
    var body: some View {
        Text("deneme")
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
        
    }
}
