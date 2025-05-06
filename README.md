NSW Planning LGAs
-----------------

This scraper runs on [Morph](https://morph.io) to scrape DA Applications for LGA's that use it.

As Date range filtering is currently broken, it initially searches for All types, but if it finds more than 5 pages
it then filters by "DA Status = On Ehxhibition".

When LGA is not set, it currently shows 11,770 results with 1308 pages of 9 cards per page, so its early days so far.

To get started [see the documentation](https://morph.io/documentation)

## To run the scraper

```
bundle exec ruby scraper.rb
```

## To run the tests

```
bundle exec rake
```

## To run style and coding checks

```
bundle exec rubocop
```


