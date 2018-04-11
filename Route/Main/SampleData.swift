/*
 * Copyright (C) 2015 - 2017, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import Material
import Graph

extension UIImage {
    public class func load(contentsOfFile name: String, ofType type: String) -> UIImage? {
        return UIImage(contentsOfFile: Bundle.main.path(forResource: name, ofType: type)!)
    }
}

struct SampleData {
    public static func createSampleData() {
        let graph = Graph()
        graph.clear()
        
        let c1 = Entity(type: "Category")
        c1["name"] = "Future"
        
        let a1 = Entity(type: "Article")
        a1["title"] = "Travel Made Easy!"
        a1["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a1["photo"] = UIImage.load(contentsOfFile: "photo1", ofType: "png")?.resize(toHeight: 300)
        a1["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
        
        a1.is(relationship: "Post").in(object: c1)
        
        let a2 = Entity(type: "Article")
        a2["title"] = "Travel Made Easy!"
        a2["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a2["photo"] = UIImage.load(contentsOfFile: "photo2", ofType: "png")?.resize(toHeight: 300)
        a2["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
        
        a2.is(relationship: "Post").in(object: c1)
        
        let c2 = Entity(type: "Category")
        c2["name"] = "Past"
        
        let a3 = Entity(type: "Article")
        a3["title"] = "Travel Made Easy!"
        a3["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a3["photo"] = UIImage.load(contentsOfFile: "photo4", ofType: "png")?.resize(toHeight: 300)
        a3["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
        
        a3.is(relationship: "Post").in(object: c2)
        
        let a4 = Entity(type: "Article")
        a4["title"] = "Travel Made Easy!"
        a4["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a4["photo"] = UIImage.load(contentsOfFile: "photo3", ofType: "png")?.resize(toHeight: 300)
        a4["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy! :)"
        
        a4.is(relationship: "Post").in(object: c2)
        
        let c3 = Entity(type: "Category")
        c3["name"] = "Ongoing"
        
        let a5 = Entity(type: "Article")
        a5["title"] = "Travel Made Easy!"
        a5["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a5["photo"] = UIImage.load(contentsOfFile: "photo2", ofType: "png")?.resize(toHeight: 300)
        a5["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!?"
        
        a5.is(relationship: "Post").in(object: c3)
        
        let a6 = Entity(type: "Article")
        a6["title"] = "Travel Made Easy!"
        a6["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a6["photo"] = UIImage.load(contentsOfFile: "photo3", ofType: "png")?.resize(toHeight: 300)
        a6["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy!"
        
        a6.is(relationship: "Post").in(object: c3)
        
        let a7 = Entity(type: "Article")
        a7["title"] = "Travel Made Easy!"
        a7["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a7["photo"] = UIImage.load(contentsOfFile: "photo1", ofType: "png")?.resize(toHeight: 300)
        a7["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!!"

        a7.is(relationship: "Post").in(object: c3)
        
        let a8 = Entity(type: "Article")
        a8["title"] = "Travel Made Easy!"
        a8["detail"] = " http://sparkdeath324.pythonanywhere.com/"
        a8["photo"] = UIImage.load(contentsOfFile: "photo5", ofType: "png")?.resize(toHeight: 300)
        a8["content"] = "Travel Made Easy!Travel Made Easy!Travel Made Easy!Travel Made Easy! :)"
        
        a8.is(relationship: "Post").in(object: c3)
        
        graph.sync()
    }
}
