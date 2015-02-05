import Quick
import Nimble

class SLEndTableViewCellSpec: QuickSpec {
    
    override func spec() {

        let cell = SLEndTableViewCell(style: .Default, reuseIdentifier: nil)
        let type = BlockType.SLEnd

        describe("type") {
            it("is SLEnd") {
                expect(cell.type) == type
            }
        }

        describe("typeLabel") {
            it("should not be visible") {
                expect(cell.typeLabel.alpha) == 0.0
            }
        }
    }
}