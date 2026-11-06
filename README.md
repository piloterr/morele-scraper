<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Morele Scraper API by Piloterr – scrape Morele data as JSON" width="100%"></a>
</p>

# Morele Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Morele Scraper API** lets you extract public data from Morele as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Morele Product API** — Read one morele.net product page.
- **Morele Search API** — Search morele.net by keyword or search URL.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Morele Product API](#morele-product-api) | `/v2/morele/product` | 1 | Read one morele.net product page. Flat JSON with PLN price, EAN, specs, and availability. |
| [Morele Search API](#morele-search-api) | `/v2/morele/search` | 1 | Search morele.net by keyword or search URL. Returns product cards with PLN prices and pagination. |

## Table of contents

- [How it works](#how-it-works)
- [Morele Product API](#morele-product-api)
- [Morele Search API](#morele-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Morele Product API

Read one morele.net product page. Flat JSON with PLN price, EAN, specs, and availability.

`GET | POST https://api.piloterr.com/v2/morele/product` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Morele product URL, or a numeric product id. |
| `return_page_source` | boolean | — | When true, return the raw HTML as {"result": "..."}. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/morele/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.morele.net/laptop-lenovo-thinkbook-15-iil-20sm000fpb-6721152/",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type MoreleProduct = {
  id?: string;
  ean?: string;
  mpn?: string;
  url?: string;
  name?: string;
  brand?: string;
  price?: number;
  images?: string[];
  rating?: number;
  currency?: string;
  in_stock?: boolean;
  image_url?: string;
  price_net?: number;
  breadcrumbs?: {
    url?: string;
    name?: string;
  }[];
  description?: string;
  availability?: string;
  review_count?: number;
  price_display?: string;
  specifications?: {
    name?: string;
    group?: string;
    value?: string;
  }[];
  price_net_display?: string;
};

const params = new URLSearchParams({
  "query": "https://www.morele.net/laptop-lenovo-thinkbook-15-iil-20sm000fpb-6721152/",
});

const response = await fetch(`https://api.piloterr.com/v2/morele/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as MoreleProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/morele/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.morele.net/laptop-lenovo-thinkbook-15-iil-20sm000fpb-6721152/"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "6721152",
  "ean": "194632480436",
  "mpn": "20SM000FPB",
  "url": "https://www.morele.net/laptop-lenovo-thinkbook-15-iil-20sm000fpb-6721152/",
  "name": "Laptop Lenovo Thinkbook 15 IIL (20SM000FPB)",
  "brand": "Lenovo",
  "price": 3963.99,
  "images": [
    "https://images.morele.net/i1064/6721152_4_i1064.jpg",
    "https://images.morele.net/i80/6721152_5_i80.jpg"
  ],
  "rating": 5,
  "currency": "PLN",
  "in_stock": true,
  "image_url": "https://images.morele.net/i1064/6721152_4_i1064.jpg",
  "price_net": 3222.76,
  "breadcrumbs": [
    {
      "url": "https://www.morele.net/",
      "name": "Morele.net"
    },
    {
      "url": "https://www.morele.net/laptopy/",
      "name": "Laptopy"
    }
  ],
  "description": "Wyjątkowa wydajność i wygląd Wyposażony w procesor do poziomu Intel® Core™ 10 generacji i system Windows 10 Pro ThinkBook 15 działa płynn…",
  "availability": "Ostatnia sztuka!",
  "review_count": 5,
  "price_display": "3 963,99 zł",
  "specifications": [
    {
      "name": "Marka",
      "group": "Produkt",
      "value": "Lenovo"
    },
    {
      "name": "Kod producenta",
      "group": "Produkt",
      "value": "20SM000FPB"
    }
  ],
  "price_net_display": "3 222,76 zł"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `ean` | string |  |
| `mpn` | string |  |
| `url` | string |  |
| `name` | string |  |
| `brand` | string |  |
| `price` | number |  |
| `images` | string[] |  |
| `rating` | integer |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `image_url` | string |  |
| `price_net` | number |  |
| `breadcrumbs[]` | object[] |  |
| `breadcrumbs[].url` | string |  |
| `breadcrumbs[].name` | string |  |
| `description` | string |  |
| `availability` | string |  |
| `review_count` | integer |  |
| `price_display` | string |  |
| `specifications[]` | object[] |  |
| `specifications[].name` | string |  |
| `specifications[].group` | string |  |
| `specifications[].value` | string |  |
| `price_net_display` | string |  |

## Morele Search API

Search morele.net by keyword or search URL. Returns product cards with PLN prices and pagination.

`GET | POST https://api.piloterr.com/v2/morele/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Keyword or a full Morele search URL. A product URL is rejected. |
| `page` | number | — | Page number starting at 1. Page 2 asks Morele for the next screen of the same search. |
| `return_page_source` | boolean | — | When true, return the raw HTML as {"result": "..."}. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/morele/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "laptop",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type MoreleSearch = {
  results?: {
    id?: string;
    url?: string;
    name?: string;
    brand?: string;
    price?: number;
    rating?: number;
    currency?: string;
    image_url?: string;
    highlights?: {
      name?: string;
      value?: string;
    }[];
    review_count?: number;
    price_display?: string;
    installment_price?: number;
    installment_price_display?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "laptop",
});

const response = await fetch(`https://api.piloterr.com/v2/morele/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as MoreleSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/morele/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "laptop"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "6721152",
      "url": "https://www.morele.net/laptop-lenovo-thinkbook-15-iil-20sm000fpb-6721152/",
      "name": "Laptop Lenovo Thinkbook 15 IIL (20SM000FPB)",
      "brand": "Lenovo",
      "price": 3963.99,
      "rating": 5,
      "currency": "PLN",
      "image_url": "https://images.morele.net/i256/6721152_4_i256.jpg",
      "highlights": [
        {},
        {}
      ],
      "review_count": 5,
      "price_display": "3 963,99 zł",
      "installment_price": 101.74,
      "installment_price_display": "101,74 zł"
    }
  ],
  "pagination": {
    "next": "https://www.morele.net/wyszukiwarka/,,,,,,,,,,,,/2/?q=laptop",
    "page": 1,
    "per_page": 30,
    "total_pages": 50,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].brand` | string |  |
| `results[].price` | number |  |
| `results[].rating` | integer |  |
| `results[].currency` | string |  |
| `results[].image_url` | string |  |
| `results[].highlights[]` | object[] |  |
| `results[].review_count` | integer |  |
| `results[].price_display` | string |  |
| `results[].installment_price` | number |  |
| `results[].installment_price_display` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | object |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Morele plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Morele?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/morele/product` **1**, `/v2/morele/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Morele API return?

Each endpoint returns structured JSON: **Morele Product** — `id`, `ean`, `mpn`, `url`, `name`, `brand`; **Morele Search** — `results[]`, `results[].id`, `results[].url`, `results[].name`, `results[].brand`, `results[].price`.

### How do I paginate Morele results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Piloterr from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@piloterr/sdk`](https://www.npmjs.com/package/@piloterr/sdk) | `npm install @piloterr/sdk` |
| Python | [`piloterr`](https://pypi.org/project/piloterr/) | `pip install piloterr` |
| Go | [`piloterr-go`](https://pkg.go.dev/github.com/piloterr/piloterr-go) | `go get github.com/piloterr/piloterr-go` |
| .NET | [`Piloterr`](https://www.nuget.org/packages/Piloterr) | `dotnet add package Piloterr` |
| Ruby | [`piloterr`](https://rubygems.org/gems/piloterr) | `gem install piloterr` |
| PHP | [`piloterr/sdk`](https://packagist.org/packages/piloterr/sdk) | `composer require piloterr/sdk` |
| Java | [`piloterr-java`](https://github.com/piloterr/piloterr-java) | build from source, see its README |
| CLI | [`@piloterr/cli`](https://www.npmjs.com/package/@piloterr/cli) | `npm install -g @piloterr/cli` |
| MCP server | [`@piloterr/mcp`](https://www.npmjs.com/package/@piloterr/mcp) | `npx -y @piloterr/mcp` |

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Morele is a trademark of its respective owner. This repository is not affiliated with or endorsed by Morele. Examples are released under the MIT license.</sub>
