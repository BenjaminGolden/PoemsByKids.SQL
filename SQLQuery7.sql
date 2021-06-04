-- 1 What grades are stored in the database?
select * from Grade

-- 2 What emotions may be associated with a poem?
SELECT * FROM Emotion

-- 3 How many poems are in the database?
Select count(*) as Poems
from Poem

-- 4 Sort authors alphabetically by name. What are the names of the top 76 authors?
Select top 76 author.Name
from poem
LEFT JOIN Author on poem.AuthorId = Author.id 
order by author.Name

-- 5 Starting with the above query, add the grade of each of the authors.
Select top 76 author.Name,
author.gradeid as Grade
from poem
LEFT JOIN Author on poem.AuthorId = Author.id 
order by author.Name

-- 6 Starting with the above query, add the recorded gender of each of the authors.
Select top 76 author.Name,
Grade.name as Grade, 
Gender.Name as Gender
from author
LEFT JOIN grade on grade.id = author.gradeid
Left Join Gender on Gender.Id = author.GenderId
order by author.Name

-- 7 What is the total number of words in all poems in the database?
SELECT count( * ) Wordcount from Poem

-- 8 Which poem has the fewest characters?
Select poem.Title
from poem
where charcount = (
SELECT MIN(charcount)
from Poem)

-- 9 How many authors are in the third grade?
select count (*)
from author 
where gradeId = 3

-- 10 How many total authors are in the first through third grades?
select count (*)
from author
where gradeId <= 3

-- 11 What is the total number of poems written by fourth graders?
select count (*)
from poem
Left Join author on poem.AuthorId = author.Id
where gradeId = 4

-- 12 How many poems are there per grade?
select count (*) as Poems, grade.name as Grade
from poem
Left Join author on poem.authorid = author.id
Left Join grade on author.GradeId = grade.id 
group by grade.Name
order by grade.name 

-- 13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select count (*) as Authors, Grade.name as Grade
from author
Left Join grade on author.GradeId = grade.id
group by grade.name
order by grade.name 

-- 14 What is the title of the poem that has the most words?
SELECT poem.title
from poem
where WordCount = (
select Max(wordcount)
From poem)
-- 15 Which author(s) have the most poems? (Remember authors can have the same name.)
Select top 3 count (*) as NumberOfPoems, author.Id, author.name
from poem 
Left Join author on poem.AuthorId = author.Id 
group by author.id, author.name
order by NumberOfPoems desc

-- 16 How many poems have an emotion of sadness?
SELECT count (*) as poems, emotion.name as Emotion 
from PoemEmotion
left join emotion on PoemEmotion.EmotionId = emotion.Id
where emotionId = 3
group by emotion.Name

-- 17 How many poems are not associated with any emotion?

select count (*) as poems
from Poem
left join PoemEmotion on PoemEmotion.PoemId = poem.id 
where PoemEmotion.EmotionId is null

-- 18 Which emotion is associated with the least number of poems?
select top 1 count (*) poems, emotion.name as emotion
from PoemEmotion 
left join poem on PoemEmotion.PoemId = poem.Id	
left join emotion on PoemEmotion.EmotionId = Emotion.Id
group by emotion.name
order by poems

-- 19 Which grade has the largest number of poems with an emotion of joy?
select top 1 count (*) poems, emotion.name as emotion, grade.id
from Poem
left join PoemEmotion on PoemEmotion.PoemId = poem.id 
left join emotion on PoemEmotion.EmotionId = Emotion.Id
left join author on poem.AuthorId = author.id
left join grade on author.GradeId = grade.id
where emotion.id = 4
group by emotion.name, grade.Id
order by poems desc


-- 20 Which gender has the least number of poems with an emotion of fear?

select top 1 count (*) poems, emotion.name as emotion, Gender.name
from Poem
left join PoemEmotion on PoemEmotion.PoemId = poem.id 
left join emotion on PoemEmotion.EmotionId = Emotion.Id
left join author on poem.AuthorId = author.id
left join gender on author.GenderId = gender.id
where emotion.id = 2
group by emotion.name, gender.name
order by poems 