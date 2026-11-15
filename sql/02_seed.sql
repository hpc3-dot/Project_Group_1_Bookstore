-- Run after 01_schema.sql in the bookstore database.
-- This script skips existing authors, genres, book titles and genre links.

BEGIN;

-- SECTION 1: AUTHORS AND SECTION 2: GENRES
INSERT INTO authors (author_name)
VALUES
('Frank Herbert'),
('Ursula K. Le Guin'),
('Susanna Clarke'),
('William Gibson'),
('Neil Gaiman'),
('Dashiell Hammett'),
('John le Carré'),
('Jonathan Lethem'),
('Mary Shelley'),
('Shirley Jackson'),
('Jeff VanderMeer'),
('Markus Zusak'),
('Kurt Vonnegut'),
('George Eliot'),
('Gabriel García Márquez'),
('Chinua Achebe'),
('Toni Morrison'),
('Alison Bechdel'),
('W.G. Sebald'),
('Annie Ernaux')
ON CONFLICT (author_name) DO NOTHING;


INSERT INTO genres (genre_name)
VALUES
('Science Fiction'),
('Space Opera'),
('Soft Sci-Fi'),
('Speculative Fiction'),
('Feminist Sci-Fi'),
('Fantasy'),
('Historical Fantasy'),
('Alternate History'),
('Cyberpunk'),
('Hardboiled Noir'),
('Urban Fantasy'),
('Mythic Fiction'),
('Mystery'),
('Detective Fiction'),
('Hard-boiled Realism'),
('Thriller'),
('Espionage Fiction'),
('Psychological Fiction'),
('Noir'),
('Horror'),
('Gothic Fiction'),
('Psychological Horror'),
('Eco-Horror'),
('Weird Fiction'),
('Historical Fiction'),
('Young Adult'),
('Magical Realism'),
('Satire'),
('Realist Fiction'),
('Novel of Manners'),
('Literary Fiction'),
('Epic Saga'),
('Postcolonial Fiction'),
('Gothic Horror'),
('Non-Fiction'),
('Graphic Novel'),
('Memoir'),
('LGBTQ+ Literature'),
('Travelogue'),
('Biography'),
('Essay'),
('Autofiction'),
('Social History')
ON CONFLICT (genre_name) DO NOTHING;

-- SECTION 3: BOOKS
-- Find author IDs by name; do not assume fixed identity numbers.
-- Skip titles already present to avoid duplicate books.
WITH book_data (title, author_name, published_year, description) AS (
    VALUES
    ('Dune', 'Frank Herbert', 1965, 'In a sprawling feudal interstellar empire, young Paul Atreides navigates betrayal and survival on the desert planet Arrakis, the universe''s only source of the priceless spice melange.'),
    ('The Left Hand of Darkness', 'Ursula K. Le Guin', 1969, 'A lone human envoy is sent to the icy planet of Gethen to persuade its rulers to join a galactic coalition, navigating an alien society of ambisexual individuals who have no fixed gender.'),
    ('Jonathan Strange & Mr Norrell', 'Susanna Clarke', 2004, 'Set during the 19th-century Napoleonic Wars, this epic presents an alternate England where practical magic once existed and is suddenly resurrected by two clashing magicians.'),
    ('Neuromancer', 'William Gibson', 1984, 'The foundational cyberpunk novel following Case, a washed-up computer hacker hired by a mysterious employer for a final, high-stakes data-heist inside the virtual matrix.'),
    ('American Gods', 'Neil Gaiman', 2001, 'An ex-convict named Shadow becomes the bodyguard to a mysterious con man, getting caught in an brewing war between America''s ancient traditional gods and modern technological deities.'),
    ('The Maltese Falcon', 'Dashiell Hammett', 1930, 'San Francisco private eye Sam Spade gets entangled with a crew of eccentric, ruthless criminals all searching for a legendary, jewel-encrusted statuette.'),
    ('The Spy Who Came In from the Cold', 'John le Carré', 1963, 'A gritty Cold War tale stripped of glamour, following weary British agent Alec Leamas as he accepts a final, dangerous undercover assignment in East Germany.'),
    ('Gun, with Occasional Music', 'Jonathan Lethem', 1994, 'A surreal genre-blend that features a cynical private investigator navigating a futuristic, dystopian California filled with genetically evolved talking animals and state-mandated mood drugs.'),
    ('Frankenstein', 'Mary Shelley', 1818, 'Often considered the first science fiction novel, it explores the devastating consequences of hubris when young scientist Victor Frankenstein animates a creature made from scavenged body parts.'),
    ('The Haunting of Hill House', 'Shirley Jackson', 1959, 'Four paranormal researchers stay at a notoriously malevolent mansion, focusing on the terrifying psychological dissolution of an emotionally fragile volunteer.'),
    ('Annihilation', 'Jeff VanderMeer', 2014, 'A female expedition of scientists ventures into "Area X"—an abandoned, surreal coastal territory where a mysterious force is rapidly mutating nature and reality itself.'),
    ('The Book Thief', 'Markus Zusak', 2005, 'Narrated entirely by Death, the story follows a young girl named Liesel surviving in Nazi Germany by stealing books and sharing them with her neighbors and the Jewish man hidden in her basement.'),
    ('Slaughterhouse-Five', 'Kurt Vonnegut', 1969, 'An anti-war masterpiece centering on the firebombing of Dresden in WWII, experienced by protagonist Billy Pilgrim who has become "unstuck in time" and experiences his life completely out of order.'),
    ('Middlemarch', 'George Eliot', 1871, 'Set in a changing provincial English town during the 1830s, this massive narrative dissects class, marriage, political reform, and the stifling societal constraints placed on women.'),
    ('One Hundred Years of Solitude', 'Gabriel García Márquez', 1967, 'Following seven generations of the Buendía family in the mythical Colombian town of Macondo, this landmark novel seamlessly blends supernatural elements with turbulent historical realities.'),
    ('Things Fall Apart', 'Chinua Achebe', 1958, 'Chronicling the life of Okonkwo, an Igbo leader in Nigeria, the book explores the rich cultural traditions of his community alongside the devastating arrival of British colonialists and missionaries.'),
    ('Beloved', 'Toni Morrison', 1987, 'Set after the American Civil War, it follows a formerly enslaved woman whose home is haunted by the furious, tragic spirit of her infant daughter, using a ghost story to examine the generational trauma of slavery.'),
    ('Fun Home: A Family Tragicomic', 'Alison Bechdel', 2006, 'A darkly comedic, beautifully illustrated graphic memoir exploring the author''s complex relationship with her closeted father, her own coming out, and literature.'),
    ('The Rings of Saturn', 'W.G. Sebald', 1995, 'Disguised as a first-person walking tour through the English countryside, this hybrid book drifts freely into historical tangents, philosophy, and architectural memories.'),
    ('The Years', 'Annie Ernaux', 2008, 'A "collective autobiography" that spans six decades, where the author records her life not through personal milestones, but through the shifting cultural and political landscape of postwar France.')
)
INSERT INTO books (
    title,
    author_id,
    published_year,
    description,
    isbn
)
SELECT
    d.title,
    a.author_id,
    d.published_year,
    d.description,
    CASE d.title
        WHEN 'Dune' THEN '9780441172719'
        WHEN 'The Left Hand of Darkness' THEN '9780441478125'
        WHEN 'Jonathan Strange & Mr Norrell' THEN '9780765356154'
        WHEN 'Neuromancer' THEN '9780441569595'
        WHEN 'American Gods' THEN '9780062572233'
        WHEN 'The Maltese Falcon' THEN '9780679722649'
        WHEN 'The Spy Who Came In from the Cold' THEN '9780143124757'
        WHEN 'Gun, with Occasional Music' THEN '9780156028974'
        WHEN 'Frankenstein' THEN '9780141439471'
        WHEN 'The Haunting of Hill House' THEN '9780143039983'
        WHEN 'Annihilation' THEN '9780374104092'
        WHEN 'The Book Thief' THEN '9780375842207'
        WHEN 'Slaughterhouse-Five' THEN '9780385333849'
        WHEN 'Middlemarch' THEN '9780141439549'
        WHEN 'One Hundred Years of Solitude' THEN '9780060883287'
        WHEN 'Things Fall Apart' THEN '9780385474542'
        WHEN 'Beloved' THEN '9781400033416'
        WHEN 'Fun Home: A Family Tragicomic' THEN '9780618871711'
        WHEN 'The Rings of Saturn' THEN '9780811213783'
        WHEN 'The Years' THEN '9781609807870'
    END AS isbn
FROM book_data d
JOIN authors a
    ON a.author_name = d.author_name
WHERE NOT EXISTS (
    SELECT 1
    FROM books b
    WHERE b.title = d.title
);

-- SECTION 4: CONNECT ALL 20 BOOKS TO THEIR GENRES
-- 62 book-genre relationships

INSERT INTO book_genres (book_id, genre_id)
SELECT b.book_id, g.genre_id
FROM (
    VALUES
    -- Book 1: Dune
    ('Dune', 'Science Fiction'),
    ('Dune', 'Space Opera'),
    ('Dune', 'Soft Sci-Fi'),

    -- Book 2: The Left Hand of Darkness
    ('The Left Hand of Darkness', 'Science Fiction'),
    ('The Left Hand of Darkness', 'Speculative Fiction'),
    ('The Left Hand of Darkness', 'Feminist Sci-Fi'),

    -- Book 3: Jonathan Strange & Mr Norrell
    ('Jonathan Strange & Mr Norrell', 'Fantasy'),
    ('Jonathan Strange & Mr Norrell', 'Historical Fantasy'),
    ('Jonathan Strange & Mr Norrell', 'Alternate History'),

    -- Book 4: Neuromancer
    ('Neuromancer', 'Science Fiction'),
    ('Neuromancer', 'Cyberpunk'),
    ('Neuromancer', 'Hardboiled Noir'),

    -- Book 5: American Gods
    ('American Gods', 'Fantasy'),
    ('American Gods', 'Urban Fantasy'),
    ('American Gods', 'Mythic Fiction'),

    -- Book 6: The Maltese Falcon
    ('The Maltese Falcon', 'Mystery'),
    ('The Maltese Falcon', 'Detective Fiction'),
    ('The Maltese Falcon', 'Hard-boiled Realism'),

    -- Book 7: The Spy Who Came In from the Cold
    ('The Spy Who Came In from the Cold', 'Thriller'),
    ('The Spy Who Came In from the Cold', 'Espionage Fiction'),
    ('The Spy Who Came In from the Cold', 'Psychological Fiction'),

    -- Book 8: Gun, with Occasional Music
    ('Gun, with Occasional Music', 'Mystery'),
    ('Gun, with Occasional Music', 'Science Fiction'),
    ('Gun, with Occasional Music', 'Noir'),

    -- Book 9: Frankenstein
    ('Frankenstein', 'Horror'),
    ('Frankenstein', 'Gothic Fiction'),
    ('Frankenstein', 'Science Fiction'),

    -- Book 10: The Haunting of Hill House
    ('The Haunting of Hill House', 'Horror'),
    ('The Haunting of Hill House', 'Psychological Horror'),
    ('The Haunting of Hill House', 'Gothic Fiction'),

    -- Book 11: Annihilation
    ('Annihilation', 'Science Fiction'),
    ('Annihilation', 'Eco-Horror'),
    ('Annihilation', 'Weird Fiction'),

    -- Book 12: The Book Thief
    ('The Book Thief', 'Historical Fiction'),
    ('The Book Thief', 'Young Adult'),
    ('The Book Thief', 'Magical Realism'),

    -- Book 13: Slaughterhouse-Five
    ('Slaughterhouse-Five', 'Historical Fiction'),
    ('Slaughterhouse-Five', 'Satire'),
    ('Slaughterhouse-Five', 'Science Fiction'),

    -- Book 14: Middlemarch
    ('Middlemarch', 'Realist Fiction'),
    ('Middlemarch', 'Novel of Manners'),
    ('Middlemarch', 'Historical Fiction'),

    -- Book 15: One Hundred Years of Solitude
    ('One Hundred Years of Solitude', 'Literary Fiction'),
    ('One Hundred Years of Solitude', 'Magical Realism'),
    ('One Hundred Years of Solitude', 'Epic Saga'),

    -- Book 16: Things Fall Apart
    ('Things Fall Apart', 'Literary Fiction'),
    ('Things Fall Apart', 'Postcolonial Fiction'),
    ('Things Fall Apart', 'Historical Fiction'),

    -- Book 17: Beloved
    ('Beloved', 'Literary Fiction'),
    ('Beloved', 'Historical Fiction'),
    ('Beloved', 'Gothic Horror'),

    -- Book 18: Fun Home
    ('Fun Home: A Family Tragicomic', 'Non-Fiction'),
    ('Fun Home: A Family Tragicomic', 'Graphic Novel'),
    ('Fun Home: A Family Tragicomic', 'Memoir'),
    ('Fun Home: A Family Tragicomic', 'LGBTQ+ Literature'),

    -- Book 19: The Rings of Saturn
    ('The Rings of Saturn', 'Non-Fiction'),
    ('The Rings of Saturn', 'Travelogue'),
    ('The Rings of Saturn', 'Biography'),
    ('The Rings of Saturn', 'Essay'),

    -- Book 20: The Years
    ('The Years', 'Memoir'),
    ('The Years', 'Autofiction'),
    ('The Years', 'Social History')
) AS genre_data(title, genre_name)
JOIN books b
    ON b.title = genre_data.title
JOIN genres g
    ON g.genre_name = genre_data.genre_name
ON CONFLICT (book_id, genre_id) DO NOTHING;

COMMIT;
