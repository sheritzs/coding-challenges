
-- Convert the first letter of each word found in content_text to 
-- uppercase, while keeping the rest of the letters lowercase.

-- Your output should include the original text in one column and
-- the modified text in another column.

select
    content_text,
    initcap(content_text) as modified_text
from user_content
