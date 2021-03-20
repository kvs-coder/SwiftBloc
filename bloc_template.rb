path = ARGV[0]
class_name = ARGV[1]
type = ARGV[2]

if path.nil?
    puts "Please spicify the path"
    return
end

if class_name.nil?
    puts "Please spicify the class name"
    return
end

if type.nil?
    puts "Please spicify the type"
    return
end

File.open("#{path}/#{class_name}State.swift", 'w') do |bloc_file|
    content = <<~TEXT
        import SwiftBloc

        class #{class_name}State {
            
        }

        extension #{class_name}State: Equatable {
            static func == (lhs: #{class_name}State, rhs: #{class_name}State) -> Bool {
                <#code#>
            }
        }

        class #{class_name}Initial: #{class_name}State {
            
        }
    TEXT

    bloc_file.write content
    bloc_file.close
    puts "Created file: #{path}/#{class_name}State.swift"
end   
if type == "bloc" 
    File.open("#{path}/#{class_name}Event.swift", 'w') do |bloc_file|
        content = <<~TEXT
            import SwiftBloc

            class #{class_name}Event {
                
            }

            extension #{class_name}Event: Equatable {
                static func == (lhs: #{class_name}Event, rhs: #{class_name}Event) -> Bool {
                    <#code#>
                }
            }
        TEXT

        bloc_file.write content
        bloc_file.close
        puts "Created file: #{path}/#{class_name}Event.swift"
    end    
    File.open("#{path}/#{class_name}Bloc.swift", 'w') do |bloc_file|
        content = <<~TEXT
            import SwiftBloc

            class #{class_name}Bloc: Bloc<#{class_name}Event, #{class_name}State> {
                init() {
                    super.init(intialState: #{class_name}State())
                }
            
                override func mapEventToState(event: #{class_name}Event) -> #{class_name}State {
                    <#code#>
                }
            }
        TEXT

        bloc_file.write content
        bloc_file.close
        puts "Created file: #{path}/#{class_name}Bloc.swift"
    end    
elsif type == "cubit"
    File.open("#{path}/#{class_name}Cubit.swift", 'w') do |bloc_file|
        content = <<~TEXT
            import SwiftBloc
    
            class #{class_name}Cubit: Cubit<#{class_name}State> {
                init() {
                    super.init(state: #{class_name}State())
                }
            }
        TEXT
    
        bloc_file.write content
        bloc_file.close
        puts "Created file: #{path}/#{class_name}Cubit.swift"
    end   
else
    "Invalid type. Must be \"bloc or \"cubit"    
end  