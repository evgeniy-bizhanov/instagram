//
//  Паттерн внедрения зависимостей
//

import Swinject

/// Сборщик модулей
private let assembler: Assembler = Assembler(
    [
        ServiceAssembler(),
        AuthServiceAssembler(),
        ProfileServiceAssembler()
    ]
)

class AbstractModuleBuilder: NSObject {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.resolve(resolver: assembler.resolver)
    }
    
    func resolve(resolver: Resolver) {}
}
