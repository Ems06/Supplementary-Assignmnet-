using DataFrames

stack_status=false
box = DataFrame(Blocks=[])
table=DataFrame(Blocks=[],state_Description=[])
blocks_state=DataFrame(Blocks=[],state_Description=[])
goal_state=DataFrame(Blocks=[],state_Description=[])



function addBlock()
    print("Specify Number of Blocks")
    num=parse(Int,readline())

       for e in 1:num
       print("Enter block $e")
       block=readline()
       push!(box,(block))

       end

end
####THIS FUNCTION CONFIGURE THE BLOCKS IN THE WORLD
function configure_world(b1,b2)
push!(table,("$b1","$b1 on $b2"))
end

function goal(b1,b2)
   push!(goal_state,("$b1","$b1 on $b2"))
end

function takeAction()
   block=""
   for e in 1:size(table)[1]
      block=table[!,1][e]
      table[!,2][e]="$block on Table"
   end
   show(table)


end

function deleteList()
   for e in 1:size(table)[1]
      if length(table[!,2][e]) < 10
      del=table[!,2][e]
    print("\nDeleted facts: $del")
    print("")

   end
   end
end

function precondition()
   print("\n*******Preconditions List**********")
   precon=""
      for e in 1:size(goal_state)[1]
         if length(goal_state[!,2][e])<10
         precon=goal_state[!,1][e]
       print("\nOn table $precon")
       print("")

      end

   end
end

function stack()
   bk_stack=""
      for j in 1:size(table)[1]
         bk_stack=goal_state[!,2][j]
         if length(table[!,2][j]) < 11
         print("\n Goal: $bk_stack")
      end
      end
end
#############################################
function goal_action()
bk_stack=""
for j in 1:size(table)[1]
bk_stack=goal_state[!,2][j]
if length(table[!,2][j]) < 11
print("\n Put: $bk_stack")
end
end
end

##################################################
function unstack()
blok=""
bk_stack=""
for e in 1:size(table)[1]
blok=table[!,1][e]
#############################
if length(table[!,2][e]) < 10

print("\nPut $blok on Table")
end
end
end

function start_planner()
bk=""
fbk1=""
fbk2=""
count=0
print("\n*********************WORLD DESCRIPTION****************\n")
show(table)
print("\n Goal stack\n")
stack()
print("\n*************************ACTION************************\n")
unstack()
goal_action()
precondition()
print("\n****************DELETE LIST***********************")
deleteList()
print("\n*******************CURRENT WORLD STATE************")
takeAction()


for e in 1:size(box)[1]
bk=table[!,1][e]
if table[!,2][e]==goal_state[!,2][e]
push!(blocks_state,(table[!,1][e],true))
elseif table[!,2][e]!=goal_state[!,2][e]
push!(blocks_state,(table[!,1][e],false))
end #end of first if statement
if blocks_state[!,2][e]==true
count+=1
end # end of second if statement
if blocks_state[!,2][e]==false && length(table[!,2][e])<10
end
###########################
if blocks_state[!,2][e]==false && length(table[!,2][e])==10
end
if count == size(goal_state)[1]
print("\nCURRENT CONFIGURATION IS GOAL STATE")
end
end #end of For statement
end
