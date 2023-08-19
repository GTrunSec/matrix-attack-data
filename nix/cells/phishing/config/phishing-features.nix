{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
in
builtins.mapAttrs
  (
    n: v:
    lib.recursiveUpdate v {
      schemas.result = {
        validation = {
          type = "integer";
        };
        example = 0;
      };
    }
  )
  {
    having_ip_address = {
      schemas.data = {
        validation.type = "boolean";
        example = false;
      };
      schemas.result.rule = {
        "0" = "otherwise";
        "1" = "if IP address is present, or domain Part has an IP Address → Phishing";
      };
      description = ''
        This is generally an indicator of attempts to collect personal data,
        as many phishing websites employ this trick. All the websites employing
        this trick present in the dataset are associated with phishing websites.

        If the IP address is used as the domain of the URL, such as
        http://125.98.2.142/contoh.html, it can be suspected that attempts to steal information.
        The IP address can also be converted into hexadecimal code.
      '';
    };
    url_length = {
      schemas.data = {
        validation.type = "integer";
        example = 100;
      };
      schemas.result.rule = {
        "0" = "if URL Length < 54 → Legitimate";
        "-1" = "if 54 ≤ URL Length ≤ 75  → suspicious";
        "1" = "otherwise → Phishing";
      };
      description = ''
        Phishing websites often hide suspicious parts of their URLs at the
        end of long URLs which redirect the information submitted by users
        or redirect the web page itself. A length of 54 characters has been
        suggested in previous research [27] to separate phishing websites from legitimate ones.

        Long URLs can also be suspected of being a phishing site like this one:
        http://mencobasitus.com.nr/4c/rea/4b53e4i6f913e51234hfyg46f363r734/?cmd=_home&
        dispatch=1212325vdvtyvwtew5wtetuyuijba5672uh2bi2822gy267gehh74y7@phishing.
        website.html. If the URL length greater than or equal to 54 characters then the URL
        included as a phishing site.
      '';
    };
    shortening_service = {
      schemas.data = {
        validation.type = "string";
        example = "<TinyURL>";
      };
      schemas.result.rule = {
        "0" = "Otherwise → Legitimate";
        "1" = "TinyURL → Phishing";
      };
      description = ''
        Whehter usu the https://zapier.com/blog/best-url-shorteners/ service

        URL shortening is a method in which a URL is made to be shorter, which this domain
        will connect to the web page that has a URL that is longer such, http://sekolah.ini.ac.id/
        URLs can be shortened to "bit.ly/21FXWl5",
      '';
    };
    having_special_symbols = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      description = "having [`@` `~` `-`] symbols in url";
    };
    double_slash_redirecting = {
      schemas.data = {
        validation.type = "string";
        example = "redirected url";
      };
      schemas.result.rule = {
        "0" = "Otherwise → Legitimate";
        "1" = "The Position of the Last Occurrence of '//' in the URL";
      };
      description = ''
        https://www.virtuesecurity.com/kb/url-redirection-attack-and-defense/

        Double slash or "//" indicates that the user or the user will be redirected to another site.
        The position of the use of double slash usually appears at the sixth position as written at
        this link http://amikom.ac.id. However, if the double slash appears in the seventh
        position as https://amikom.ac.id it can be suspected as a phishing site.
      '';
    };

    prefix_suffix = {
      schemas.data = {
        validation.type = "array";
        example = [
          "amikom"
          "keren"
        ];
      };
      schemas.result.rule = {
        "0" = "Otherwise → Legitimate";
        "1" = "Domain Name Part Includes (−) symbol -> phishing";
      };
      description = ''
        Whether URL contains prefix or suffix separated by '-'

        Rarely a legitimate URL using symbols dashboard, but phisher will add a prefix or
        suffix to be separated by (-) in the domain name, so the user will think to have a
        legitimate access to sites such as http://www.amikom-keren.com.
      '';
    };
    having_sub_domain = {
      schemas.data = {
        validation.type = "array";
        example = [
          "part_1"
          "part_2"
          "part_3"
        ];
      };
      schemas.result.rule = {
        "0" = "Dots In Domain Part = 1 → Legitimate";
        "1" = "Otherwise → Phishing";
        "-1" = "Dots In Domain Part = 2 → Suspicious";
      };
      description = ''
        https://stackoverflow.com/questions/57796854/find-count-of-domains-and-subdomains-in-the-list-of-strings-using-python
        Whether count of sub domains in URL is legitimate, suspicious or phishing

        - https://www.tripwire.com/state-of-security/security-data-protection/phishers-using-redirector-sites-with-custom-subdomains-for-evasion/

        The domain name may have a code for each country (cc TLD) such as "id", or for an
        academic educational institution "ac" and combined "ac.id" or also called two-level
        domain (SLD). Stages for extracting the feature of the first to do is remove the "www"
        in the URL and remove cc DTL if any. Then calculate the remaining dots, if the number
        of points is greater than one, then the URL can be classified as "suspect" because of
        only the subdomain. However, if the number of points greater than the two it will be
        categorized as a phishing because it has several subdomains, and sites categorized as
        legitimate if it does not have a subdomain
      '';
    };
    ssl_final_state = {
      schemas.data = {
        validation = {
          type = "array";
          items = {
            type = "object";
            properties = {
              port = {
                type = "string";
              };
              certificate = {
                type = "array";
                items = {
                  type = "object";
                  properties = {
                    issuer.type = "string";
                    commonName.type = "string";
                    notBefore = {
                      type = "string";
                    };
                    notAfter = {
                      type = "string";
                    };
                    error.type = "string";
                    sans = {
                      type = "array";
                    };
                  };
                };
              };
            };
          };
        };
        example = [ {
          port = "443";
          certificat = [ {
            issuer = "C=US, O=DigiCert Inc, OU=www.digicert.com, CN=DigiCert SHA2 Extended Validation Server CA";
            commonName = "www.google.com";
            notBefore = "2019-10-09T00:00:00Z";
            notAfter = "2020-10-09T12:00:00Z";
            error = "";
            sans = [
              "www.google.com"
              "google.com"
            ];
          } ];
        } ];
      };
      schemas.result.rule = {
        "0" = "if uses HTTPS & trusted issuer & age >= 1 year";
        "1" = "otherwise";
        "-1" = "if uses HTTPS is not trusted -> Suspicious";
      };
      description = ''
        SSL (Secure Sockets Layer) is amongst the most widely used security protocols today.
        SSL certificates display indicators on typing an address into the status bar,
        such as the usage of the HTTPS Protocol, which is more secure and uses port 443 instead
        of port 80 used by HTTP Protocol. However, many phishing websites use fake HTTPS protocols
        to deceive users, and this parameter checks if the protocol is offered by a trusted issuer or not.
      '';
    };
    domain_registeration_date = {
      schemas.data = {
        validation = {
          type = "string";
          format = "date-time";
        };
        example = "2003-10-11T22:14:15.003Z";
      };
      schemas.result.rule = {
        "1" = "Domains Expires on ≤ 1 year → Phishing";
        "0" = "otherwise";
      };
      description = "Whether domain expires in less than a year or not. {-1, 1}";
    };
    favicon = {
      schemas.data = {
        validation.type = "boolean";
        example = false;
      };
      schemas.result.rule = {
        "0" = "Otherwise → Legitimae";
        "1" = "Favicon Loaded From External Domain -> phishing";
      };
      description = ''
        Whether favicon is loaded from external domain or not. {-1, 1}

        Favicon is an image used as an icon on a website, favicon also indicates the identity of
        the website. However, if the favicon is displayed apart in the address bar, it can be
        suspected that the website is a phishing website.
      '';
    };
    port = {
      schemas.data = {
        validation.type = "boolean";
        example = false;
      };
      schemas.result.rule = {
        "0" = "Otherwise -> Legitimate";
        "1" = "Port is of the Preferred Status → Phishing";
      };
      description = ''
        Whether port is of preferred status or not. {-1, 1}

        Port used to validate certain services such as HTTP. The use of a firewall, proxy, and
        Network Address Translation or NAT can perform automatic blocking and can be
        opened in accordance with the wishes. But if all the ports are opened, then the phisher
        will find loopholes and enable any desired services such as stealing information.
      '';
    };
    https_token = {
      schemas.data = {
        validation.type = "boolean";
        example = false;
      };
      schemas.result.rule = {
        "0" = "otherwise";
        "1" = "Using HTTP Token in Domain Part of The URL → Phishing";
      };
      description = ''
        Whether https token is part of domain or not.

        In general, the https token can be added by phisher on the domain URL and has the
        objective to distract the user like at http://https-www-amikom-coolest-college.com/
      '';
    };
    request_url = {
      schemas.data = {
        validation.type = "string";
        example = "22%";
      };
      schemas.result.rule = {
        "-1" = "if 22% ≤ Request URL ≤ 61%";
        "0" = "if Request URL < 22%";
        "1" = "otherwise";
      };
      description = ''
        This feature caculates the percentage of obects, such as videos,
        and images are loaded from a domain other than the one typed in the URL address bar.

        On the website is legal, website addresses, pictures, videos, and sounds contained on the
        web page with the same domain and does not take away from another domain.
      '';
    };
    url_of_anchor = {
      schemas.data = {
        validation.type = "string";
        example = "30%";
      };
      schemas.result.rule = {
        "-1" = "if 31% ≤ URL Anchor ≤ 67%";
        "1" = "otherwise";
        "0" = "if URL Anchor < 31%";
      };
      description = ''
        This feature refers to the percentage of links within a webpage that
        point to a different domain name than the one in the address bar.

        Whether percentage of url in anchor tags reference external domain or self falls in legitimate,
        suspicious or phishy category. {-1, 0, 1}

        If the tag is <a> and the website has a different domain name, it can be suspected as
        phishing.
      '';
    };
    links_in_tags = {
      schemas.data = {
        validation = {
          type = "object";
          properties = {
            link = {
              type = "array";
            };
            script = {
              type = "array";
            };
            meta = {
              type = "array";
            };
          };
        };
        example = {
          script = [ "<links>" ];
          meta = [ "<links>" ];
          link = [ "<links>" ];
        };
      };
      schemas.result.rule = {
        "0" = "Links in <Meta>, <Script> and  <Link> < 17% → Legitimate";
        "1" = "Otherwise → Phishing";
        "-1" = "links ≥ 17% And ≤ 81% → Suspicious";
      };
      description = ''
        Whether percentage of links in meta, script, link tags referencing external
        domain falls in legitimate, suspicious or phishy category. {-1, 0, 1}

        In general, legal sites also use <meta> tag, the <script> tag and <link> tag. And the tag
        comes from the same domain.
      '';
    };
    server_form_handle = {
      schemas.data = {
        validation.type = "array";
        example = [ "SFH" ];
      };
      schemas.result.rule = {
        "0" = "otherwise (information is processed from same domain) -> Legitimate";
        "1" = "if 'about:blank' or empty → Phishing";
        "-1" = "if redirects to a different domain → Suspicious";
      };
      description = ''
        When information is entered into a legitimate website,
        the information is processed from the same domain from where the website is loaded.
        Phishers resort to either transferring data to a different domain or leave the server form handle empty,
        and both of these options are identified separately from the one used by legitimate websites.
      '';
    };
    submitting_to_email = {
      schemas.data = {
        validation.type = "boolean";
        example = false;
      };
      schemas.result.rule = {
        "0" = "otherwise";
        "1" = "Using 'mail()' or 'mailto:' Function to Submit User Information → Phishing";
      };
      description = ''
        Whether the form submits information to email. {-1, 1}

        The official website will generally send personal information to the server for
        processing. While the phisher will be sending the information to his personal email, it
        can be suspected by the use of scripts on the server side functions such as "mail ()" and
        on the client side will use the mailto
      '';
    };
    abnormal_url = {
      schemas.data = {
        validation.type = "array";
        example = [
          "host_1"
          "host2"
        ];
      };
      schemas.result.rule = {
        "0" = "otherwise";
        "1" = "The Host Is Found → Phishing";
      };
      description = "Whether URL contains host name or not. {0, 1}";
    };
    redirect = {
      schemas.data = {
        validation.type = "array";
        example = [ "redirected links" ];
      };

      schemas.result.rule = {
        "0" = "otherwise";
        "1" = "The Host Name Is Not Included In URL → Phishing";
      };
      description = ''
        https://www.getastra.com/blog/911/malicious-multiple-redirection-king-of-traffic-distribution/
        Whether URL redirects less than equal to 1, between 2 and 4 or greater than 4. {0, 1}
        On the website is legitimate, then the identity of the website will be contained in the
        URL.
      '';
    };
    on_mouseover = {
      schemas.data = {
        validation.type = "array";
        example = [ "<changed status>" ];
      };
      description = "Whether onMouseOver changes status bar or not. {-1, 1}";
    };
    right_click = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      description = "Whether right click is disabled or not. {-1, 1}";
    };
    popup_widnow = {
      schemas.data = {
        # FIXME: string or boolean
        validation.type = "array";
        example = [
          "<event_string_1>"
          "<event_string_2>"
        ];
      };
      schemas.result.rule = {
        "-1" = "otherwise";
        "1" = "found value";
      };
      description = ''
        Whether pop up window contain text field or not.
        Authenticated websites do not ask users to enter confidential information in the form of pop up windows.

        It is unusual to find a legitimate website asking users to submit their personal information
        through a pop-up window. On the other hand, this feature has been used in some legitimate websites and its main goal is to warn users about fraudulent activities or broadcast a welcome announcement, though no personal information was asked to be filled in through these pop-up windows.
      '';
    };
    iframe = {
      schemas.data = {
        validation.type = "array";
        example = [
          "<iframe src=’https://www.infosecinstitute.com/’ width=’1′ height=’1′ style=’visibility: hidden;’></iframe>"
        ];
      };
      description = ''
        https://blog.bitsrc.io/4-security-concerns-with-iframes-every-web-developer-should-know-24c73e6a33e4
        Whether page contains iframe tag or not. {-1, 1}
      '';
      example = ''
        """
        {
        data = '''
        <iframe src=’https://www.infosecinstitute.com/’ width=’1′ height=’1′ style=’visibility: hidden;’></iframe>
        '''
        };
        """
      '';
    };
    age_of_domain = {
      schemas.data = {
        validation = {
          "type" = "string";
          "format" = "date-time";
        };
        example = "2003-10-11T22:14:15.003Z";
      };
      schemas.result.rule = {
        "1" = " 1 day > age ≤ 3 months";
        "−1" = "3 months > age ≤ 1 year";
        "0" = ">= otherwise";
      };
      description = ''
        Websites that have been online for less than a year could be risky,
        as opposed to long established legitimate websites. Websites have been
        classified into two classes, based on whether their age was less than
        or equal to 6 months, or whether it was more than six months.
        Most short-lived phishing websites would thus be placed in the first class.
      '';
    };
    dns_record = {
      schemas.data = {
        validation = {
          type = "object";
          properties = {
            master_ns = {
              type = "array";
            };
            ns = {
              type = "array";
            };
            master_mx.type = "array";
            mx.type = "array";
            master_txt.type = "array";
            txt.type = "array";
            master_cname.type = "array";
            cname.type = "array";
            master_a.type = "array";
            a.type = "array";
          };
        };
        example = {
          master_ns = [
            "ns1.google.com"
            "ns2.google.com"
          ];
          ns = [
            "ns1.google.com"
            "ns2.google.com"
          ];
          master_mx = [
            "aspmx.l.google.com"
            "alt1.aspmx.l.google.com"
            "alt2.aspmx.l.google.com"
            "alt3.aspmx.l.google.com"
            "alt4.aspmx.l.google.com"
          ];
          mx = [
            "aspmx.l.google.com"
            "alt1.aspmx.l.google.com"
            "alt2.aspmx.l.google.com"
            "alt3.aspmx.l.google.com"
            "alt4.aspmx.l.google.com"
          ];
          master_txt = [ "v=spf1 include:_spf.google.com ~all" ];
          txt = [ "v=spf1 include:_spf.google.com ~all" ];
          master_cname = [ "www.google.com" ];
          cname = [ "www.google.com" ];
          master_a = [ "192.185.98.9" ];
          a = [ "192.185.98.9" ];
        };
      };
      schemas.result.rule = {
        "1" = "None";
        "-1" = "found";
      };
      description = ''
        Whether there is DNS record for the domain or not. {-1, 1}
        For phishing websites, either the claimed identity is not recognized by the WHOIS database
        or no records founded for the hostname (Pan and Ding 2006). If the DNS record is empty or not
        found then the website is classified as “Phishing”, otherwise it is classified as “Legitimate”.
      '';
      zeek = true;
    };
    alexa_rank = {
      schemas.data = {
        validation.type = "integer";
        example = 15000;
      };
      schemas.result.rule = {
        "1" = "otherwise (no data available)";
        "-1" = "if Alexa Rank <= 150, 000";
        "0" = "if Alexa Rank >= 150, 000";
      };
      description = ''
        Legitimate websites often have high traffic as they are visited regularly,
        but most short-lived phishing websites are low-ranked and do not attract many visitors.
        The Alexa Ranks of websits have been used to evaluate this parameter,
        which are computed taking into consideration daily unique visitors and page views
        over a time period of 3 months [28]. Legitimate websites generally have ranks less than or equal to 150,000
      '';
      zeek = true;
    };

    google_search_api = {
      schemas.data = {
        validation = {
          type = "object";
          properties = {
            index = {
              type = "integer";
            };
            links_to_page = {
              type = "integer";
            };
          };
        };
        example = {
          index = 0;
          links_pointing_to_page = 0;
        };
      };
      schemas.result.rule = {
        "links_pointing_to_page" = ''
          0 = "0> <=2";
          1 = "> 2";
          -1 = "==0";
        '';
        "index" = ''
          0 =  >= 3
          -1 =  >1 result < 3
          1 =  < 1
        '';
      };
      description = ''
        Google API information
      '';
    };

    statistical_report = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      schemas.result.rule = {
        "1" = "found phishing url/ip in APIs";
        "-1" = "otherwise";
      };
      description = "Host belongs to top phishing IPs or domains or not. {-1, 1}";
    };
    google_phishing_api = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      schemas.result.rule = {
        "1" = "found phishing url/ip";
        "0" = "otherwise";
      };
      description = "Host founds in Google Phishing IPs or domains or not. {-1, 1}";
    };
    having_pound_sign = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      schemas.result.rule = {
        "1" = "found mail address url/ip";
        "0" = "otherwise";
      };
      description = "Mail address founds in url or domains or not. {0, 1}";
    };
    starts_with_dot = {
      schemas.data = {
        validation.type = "boolean";
        example = true;
      };
      schemas.result.rule = {
        "1" = "found string";
        "0" = "otherwise";
      };
      description = "Whether the url contains `./.` `././.` or not. {0, 1}";
    };
  }
