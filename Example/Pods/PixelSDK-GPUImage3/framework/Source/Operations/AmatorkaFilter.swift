/** A photo filter based on Photoshop action by Amatorka
 http://amatorka.deviantart.com/art/Amatorka-Action-2-121069631
 */

public class AmatorkaFilter: LookupFilter {
    public override init() {
        super.init()
        
        ({lookupImage = try? PictureInput(imageName:"lookup_amatorka.png")})()
        ({intensity = 1.0})()
    }
}
